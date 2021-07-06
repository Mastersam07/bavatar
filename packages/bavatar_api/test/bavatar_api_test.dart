// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:bavatar_api/bavatar_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('BavatarApiClient', () {
    late http.Client httpClient;
    late BavatarApiClient bavatarApiClient;

    setUpAll(() {
      registerFallbackValue<Uri>(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      bavatarApiClient = BavatarApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(BavatarApiClient(), isNotNull);
      });
    });

    group('getBavatars', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await bavatarApiClient.getBavatars();
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('bavatar.herokuapp.com', '/api/avatar'),
          ),
        ).called(1);
      });

      test('throws BavatarRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await bavatarApiClient.getBavatars(),
          throwsA(isA<BavatarRequestFailure>()),
        );
      });

      test('throws BavatarNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await bavatarApiClient.getBavatars(),
          throwsA(isA<BavatarNotFoundFailure>()),
        );
      });

      test('throws BavatarNotFoundFailure on empty data', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"data": []}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await bavatarApiClient.getBavatars(),
          throwsA(isA<BavatarNotFoundFailure>()),
        );
      });

      test('returns bavatar on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
         {
            "error": false,
            "data": [
              {
                "id": 12,
                "url": "mock_url",
                "name": "bavatar",
                "email": "me@bavatar.co",
                "gender": "male",
                "age_range": "18-25",
                "nature": "casual",
                "created_at": "2020-10-26T00:20:01.840132Z",
                "updated_at": "2020-10-26T00:20:01.840132Z"
              }
            ]
          }
        ''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await bavatarApiClient.getBavatars();
        expect(
          actual,
          isA<BavatarModel>()
              .having((w) => w.error, 'error', false)
              .having((w) => w.data, 'data', [
            isA<Bavatar>()
                .having((b) => b.id, 'id', 12)
                .having((b) => b.url, 'url', 'mock_url')
                .having((b) => b.name, 'name', 'bavatar')
                .having((b) => b.email, 'email', 'me@bavatar.co')
                .having((b) => b.gender, 'gender', 'male')
                .having((b) => b.ageRange, 'ageRange', '18-25')
                .having((b) => b.nature, 'nature', BavatarNature.casual)
                .having((b) => b.createdAt, 'createdAt',
                    DateTime.parse('2020-10-26T00:20:01.840132Z'))
                .having((b) => b.updatedAt, 'updatedAt',
                    DateTime.parse('2020-10-26T00:20:01.840132Z')),
          ]),
        );
      });
    });
  });
}
