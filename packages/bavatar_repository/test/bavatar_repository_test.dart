// ignore_for_file: prefer_const_constructors
import 'package:bavatar_api/bavatar_api.dart' as bavatar_api;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bavatar_repository/bavatar_repository.dart';

class MockBavatarApiClient extends Mock
    implements bavatar_api.BavatarApiClient {}

class MockBavatarModel extends Mock implements bavatar_api.BavatarModel {}

void main() {
  group('BavatarRepository', () {
    late bavatar_api.BavatarApiClient bavatarApiClient;
    late BavatarRepository bavatarRepository;

    setUp(() {
      bavatarApiClient = MockBavatarApiClient();
      bavatarRepository = BavatarRepository(
        bavatarApiClient: bavatarApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal BavatarApiClient when not injected', () {
        expect(BavatarRepository(), isNotNull);
      });
    });

    group('getBavatars', () {
      test('calls getBavatars', () async {
        try {
          await bavatarRepository.getBavatars();
        } catch (_) {}
        verify(() => bavatarApiClient.getBavatars()).called(1);
      });

      test('throws when getBavatars fails', () async {
        final exception = Exception('oops');
        when(() => bavatarApiClient.getBavatars()).thenThrow(exception);
        expect(
          () async => await bavatarRepository.getBavatars(),
          throwsA(exception),
        );
      });

      test('throws when getBavatar fails', () async {
        final exception = Exception('oops');
        var bavatar = MockBavatarModel();
        when(() => bavatar.data.length).thenReturn(0);
        when(() => bavatarApiClient.getBavatars()).thenAnswer(
          (_) => Future.value(bavatar),
        );
        when(() => bavatarApiClient.getBavatars()).thenThrow(exception);
        expect(
          () async => await bavatarRepository.getBavatars(),
          throwsA(exception),
        );
      });

      test('returns correct bavatar on success (casual)', () async {
        final bavatar = MockBavatarModel();

        var time = DateTime.parse('2020-10-26T00:20:01.840132Z');

        when(() => bavatar.data).thenReturn([
          bavatar_api.Bavatar(
            id: 1,
            url: 'mock_url',
            gender: 'male',
            ageRange: '10-18',
            nature: bavatar_api.BavatarNature.casual,
            createdAt: time,
            updatedAt: time,
          )
        ]);

        when(() => bavatarApiClient.getBavatars()).thenAnswer(
          (_) async => bavatar,
        );
        final actual = await bavatarRepository.getBavatars();
        expect(
          actual,
          [
            Bavatar(
              id: 1,
              url: 'mock_url',
              gender: 'male',
              ageRange: '10-18',
              type: BavatarType.casual,
              createdAt: time,
              updatedAt: time,
            )
          ],
        );
      });

      test('returns correct bavatar on success (professional)', () async {
        final bavatar = MockBavatarModel();

        var time = DateTime.parse('2020-10-26T00:20:01.840132Z');

        when(() => bavatar.data).thenReturn([
          bavatar_api.Bavatar(
            id: 1,
            url: 'mock_url',
            gender: 'male',
            ageRange: '10-18',
            nature: bavatar_api.BavatarNature.professional,
            createdAt: time,
            updatedAt: time,
          )
        ]);

        when(() => bavatarApiClient.getBavatars()).thenAnswer(
          (_) async => bavatar,
        );
        final actual = await bavatarRepository.getBavatars();
        expect(
          actual,
          [
            Bavatar(
              id: 1,
              url: 'mock_url',
              gender: 'male',
              ageRange: '10-18',
              type: BavatarType.professional,
              createdAt: time,
              updatedAt: time,
            )
          ],
        );
      });

      test('returns correct bavatar on success (unknown)', () async {
        final bavatar = MockBavatarModel();

        var time = DateTime.parse('2020-10-26T00:20:01.840132Z');

        when(() => bavatar.data).thenReturn([
          bavatar_api.Bavatar(
            id: 1,
            url: 'mock_url',
            gender: 'male',
            ageRange: '10-18',
            nature: bavatar_api.BavatarNature.unknown,
            createdAt: time,
            updatedAt: time,
          )
        ]);

        when(() => bavatarApiClient.getBavatars()).thenAnswer(
          (_) async => bavatar,
        );
        final actual = await bavatarRepository.getBavatars();
        expect(
          actual,
          [
            Bavatar(
              id: 1,
              url: 'mock_url',
              gender: 'male',
              ageRange: '10-18',
              type: BavatarType.unknown,
              createdAt: time,
              updatedAt: time,
            )
          ],
        );
      });
    });
  });
}
