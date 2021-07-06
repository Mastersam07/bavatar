import 'package:bavatar/bavatar/bavatar.dart';
import 'package:bavatar_repository/bavatar_repository.dart' show BavatarType;
import 'package:bavatar_repository/bavatar_repository.dart'
    as bavatar_repository;
import 'package:test/test.dart';

void main() {
  var bavatar = Bavatar(
    id: 12,
    url: 'mock_url',
    gender: 'male',
    ageRange: '18-25',
    type: BavatarType.casual,
    createdAt: DateTime.parse('2020-10-26T00:20:01.840132Z'),
    updatedAt: DateTime.parse('2020-10-26T00:20:01.840132Z'),
  );

  final bavatarRepo = bavatar_repository.Bavatar(
    id: 1,
    url: 'mock_url',
    gender: 'male',
    ageRange: '18-25',
    type: BavatarType.casual,
    createdAt: DateTime(2021),
    updatedAt: DateTime(2021),
  );

  var json = <String, dynamic>{
    'id': 1325,
    'url': 'mock_rul',
    'gender': 'male',
    'ageRange': '18-25',
    'type': 'casual',
    'createdAt': DateTime(2021).toIso8601String(),
    'updatedAt': DateTime(2021).toIso8601String()
  };

  group('Bavatar', () {
    group('fromJson', () {
      test('throws throwsArgumentError when enum is unknown', () {
        expect(
          () {
            json['type'] = '';
            return Bavatar.fromJson(json);
          },
          throwsArgumentError,
        );
      });
    });
    group('toJson', () {
      test('returns valid map', () {
        var matcher = <String, dynamic>{
          'id': 12,
          'url': 'mock_url',
          'gender': 'male',
          'ageRange': '18-25',
          'type': 'casual',
          'createdAt': '2020-10-26T00:20:01.840132Z',
          'updatedAt': '2020-10-26T00:20:01.840132Z'
        };
        expect(
          bavatar.toJson(),
          equals(matcher),
        );
      });
    });
    group('fromRepository', () {
      test('returns valid Bavatar Object from fromRepository', () {
        expect(
          Bavatar.fromRepository(bavatarRepo),
          isA<Bavatar>(),
        );
      });
    });
    group('.empty', () {
      test('returns valid Bavatar Object', () {
        expect(
          Bavatar.empty,
          isA<Bavatar>(),
        );
      });
    });
    group('toMap', () {
      test('returns valid Bavatar Object', () {
        json['type'] = 'casual';
        expect(
          Bavatar.fromJson(json),
          isA<Bavatar>(),
        );
      });
    });
  });
}
