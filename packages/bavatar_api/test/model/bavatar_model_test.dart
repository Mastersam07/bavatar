import 'package:bavatar_api/bavatar_api.dart';
import 'package:test/test.dart';

void main() {
  var bavatar = Bavatar(
    id: 12,
    url: 'mock_url',
    name: 'bavatar',
    email: 'me@bavatar.co',
    gender: 'male',
    ageRange: '18-25',
    nature: BavatarNature.casual,
    createdAt: DateTime.parse('2020-10-26T00:20:01.840132Z'),
    updatedAt: DateTime.parse('2020-10-26T00:20:01.840132Z'),
  );

  var json = <String, dynamic>{
    'id': 1325,
    'url': 'mock_rul',
    'name': null,
    'email': null,
    'gender': 'male',
    'age_range': '18-25',
    'nature': 'casual',
    'created_at': DateTime.now().toIso8601String(),
    'updated_at': DateTime.now().toIso8601String()
  };

  group('Bavatar', () {
    group('fromJson', () {
      test('throws throwsArgumentError when enum is unknown', () {
        expect(
          () {
            json['nature'] = '';
            return Bavatar.fromJson(json);
          },
          throwsArgumentError,
        );
      });
    });
    group('toJson', () {
      test('returns valid map', () {
        expect(
          bavatar.toJson(),
          isA<Map<String, dynamic>>(),
        );
      });
    });
    group('toMap', () {
      test('returns valid Bavatar Object', () {
        json['nature'] = 'casual';
        expect(
          Bavatar.fromJson(json),
          isA<Bavatar>(),
        );
      });
    });
  });

  group('BavatarModel', () {
    group('toJson', () {
      test('returns valid Json', () {
        Map<String, dynamic> bavatarModel = BavatarModel(
          error: false,
          data: [
            bavatar,
          ],
        ).toJson();

        Map<String, dynamic> matcher = {
          'error': false,
          'data': [
            {
              'id': 12,
              'url': 'mock_url',
              'name': 'bavatar',
              'email': 'me@bavatar.co',
              'gender': 'male',
              'age_range': '18-25',
              'nature': 'casual',
              'created_at': '2020-10-26T00:20:01.840132Z',
              'updated_at': '2020-10-26T00:20:01.840132Z'
            }
          ]
        };

        expect(
          bavatarModel,
          equals(matcher),
        );
      });
    });

    group('toMap', () {
      test('returns valid BavatarModel Object', () {
        json['nature'] = 'casual';
        expect(
          BavatarModel.fromJson({
            'error': false,
            'data': [json]
          }),
          isA<BavatarModel>(),
        );
      });
    });
  });
}
