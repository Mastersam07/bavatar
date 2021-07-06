import 'package:bavatar/bavatar/bavatar.dart';
import 'package:test/test.dart';

void main() {
  var json = <String, dynamic>{
    'bavatarsList': {
      'bavatars': [],
    },
  };

  group('BavatarState', () {
    group('fromJson', () {
      test('throws throwsArgumentError when enum is null', () {
        json['status'] = null;

        expect(
          () => BavatarState.fromJson(json),
          throwsArgumentError,
        );
      });
      test('throws throwsArgumentError when enum is unknown', () {
        json['status'] = '_';

        expect(
          () => BavatarState.fromJson(json),
          throwsArgumentError,
        );
      });
      test('returns valid Map', () {
        json['status'] = 'initial';

        expect(
          BavatarState.fromJson(json).toJson(),
          isA<Map<String, dynamic>>(),
        );
      });
    });

    group('toJson', () {
      test('returns valid BavatarState object', () {
        json['status'] = 'initial';
        const state = BavatarState(status: BavatarStatus.loading);

        expect(
          state.toJson(),
          isA<Map<String, dynamic>>(),
        );
      });
    });
  });

  group('BavatarStatus', () {
    test('BavatarStatus.initial returns true', () {
      const state = BavatarState(status: BavatarStatus.initial);

      expect(state.status.isInitial, true);
    });
    test('BavatarStatus.loading returns true', () {
      const state = BavatarState(status: BavatarStatus.loading);

      expect(state.status.isLoading, true);
    });
    test('BavatarStatus.failure returns true', () {
      const state = BavatarState(status: BavatarStatus.failure);

      expect(state.status.isFailure, true);
    });
    test('BavatarStatus.success returns true', () {
      const state = BavatarState(status: BavatarStatus.success);

      expect(state.status.isSuccess, true);
    });
    test('BavatarState.copyWith returns valid state', () {
      const state = BavatarState(status: BavatarStatus.success);

      var failure = const BavatarState(status: BavatarStatus.failure);
      expect(state.copyWith(status: BavatarStatus.failure), failure);
    });
  });
}
