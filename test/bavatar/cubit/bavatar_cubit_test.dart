// ignore_for_file: prefer_const_constructors
import 'package:bavatar/bavatar/bavatar.dart';
import 'package:bavatar/bavatar/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bavatar_repository/bavatar_repository.dart'
    as bavatar_repository;

final testRepoBavatar = bavatar_repository.Bavatar(
  id: 1,
  url: 'mock_url',
  gender: 'male',
  ageRange: '10-18',
  type: bavatar_repository.BavatarType.professional,
  createdAt: DateTime(2021),
  updatedAt: DateTime(2021),
);

List<Bavatar> get testBavatars =>
    BavatarsList.fromRepository([testRepoBavatar]).bavatars;

class MockBavatarRepository extends Mock
    implements bavatar_repository.BavatarRepository {}

class MockBavatar extends Mock implements bavatar_repository.Bavatar {}

void main() {
  group('BavatarCubit', () {
    late bavatar_repository.BavatarRepository bavatarRepository;
    late BavatarCubit bavatarCubit;

    // setUpAll(initHydratedBloc);

    setUp(() {
      bavatarRepository = MockBavatarRepository();
      when(() => bavatarRepository.getBavatars())
          .thenAnswer((_) async => [testRepoBavatar]);
      bavatarCubit = BavatarCubit(bavatarRepository);
    });

    tearDown(() {
      bavatarCubit.close();
    });

    test('initial state is correct', () {
      expect(bavatarCubit.state, BavatarState());
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        expect(
          bavatarCubit.fromJson(bavatarCubit.state.toJson()),
          bavatarCubit.state,
        );
      });
    });

    group('fetchBavatars', () {
      blocTest<BavatarCubit, BavatarState>(
        'calls getBavatar',
        build: () => bavatarCubit,
        act: (cubit) => cubit.fetchBavatars(),
        verify: (_) {
          verify(() => bavatarRepository.getBavatars()).called(1);
        },
      );

      blocTest<BavatarCubit, BavatarState>(
        'emits [loading, failure] when getBavatar throws',
        build: () {
          when(() => bavatarRepository.getBavatars())
              .thenThrow(Exception('oops'));
          return bavatarCubit;
        },
        act: (cubit) => cubit.fetchBavatars(),
        expect: () => <BavatarState>[
          BavatarState(status: BavatarStatus.loading),
          BavatarState(status: BavatarStatus.failure),
        ],
      );

      blocTest<BavatarCubit, BavatarState>(
        'emits [loading, success] when getBavatar returns data',
        build: () => bavatarCubit,
        act: (cubit) => cubit.fetchBavatars(),
        expect: () => <dynamic>[
          BavatarState(status: BavatarStatus.loading),
          isA<BavatarState>()
              .having((w) => w.status, 'status', BavatarStatus.success)
              .having(
                (w) => w.bavatarsList,
                'bavatar',
                isA<BavatarsList>()
                    .having((w) => w.bavatars, 'bavatars', isNotNull)
                    .having((w) => w.bavatars, 'bavatarsList', testBavatars),
              ),
        ],
      );
    });

    group('refreshBavatar', () {
      blocTest<BavatarCubit, BavatarState>(
        'emits nothing when status is not success',
        build: () => bavatarCubit,
        act: (cubit) => cubit.refreshBavatars(),
        seed: () => BavatarState(status: BavatarStatus.failure),
        expect: () => <BavatarState>[],
        verify: (_) {
          verifyNever(() => bavatarRepository.getBavatars());
        },
      );

      blocTest<BavatarCubit, BavatarState>(
        'emits nothing when location is null',
        build: () => bavatarCubit,
        seed: () => BavatarState(status: BavatarStatus.success),
        act: (cubit) => cubit.refreshBavatars(),
        expect: () => <BavatarState>[],
        verify: (_) {
          verifyNever(() => bavatarRepository.getBavatars());
        },
      );

      blocTest<BavatarCubit, BavatarState>(
        'emits nothing when exception is thrown',
        build: () {
          when(() => bavatarRepository.getBavatars())
              .thenThrow(Exception('oops'));
          return bavatarCubit;
        },
        seed: () => BavatarState(
          status: BavatarStatus.success,
          bavatarsList: BavatarsList(bavatars: testBavatars),
        ),
        act: (cubit) => cubit.refreshBavatars(),
        expect: () => <BavatarState>[],
      );

      blocTest<BavatarCubit, BavatarState>(
        'emits updated bavatar data',
        build: () => bavatarCubit,
        seed: () => BavatarState(
          status: BavatarStatus.success,
          bavatarsList: BavatarsList.fromRepository([
            testRepoBavatar,
            testRepoBavatar,
          ]),
        ),
        act: (cubit) => cubit.refreshBavatars(),
        expect: () => <Matcher>[
          isA<BavatarState>()
              .having((w) => w.status, 'status', BavatarStatus.success)
              .having(
                (w) => w.bavatarsList,
                'bavatar',
                isA<BavatarsList>()
                    .having((w) => w.bavatars, 'bavatars', isNotNull)
                    .having((w) => w.bavatars, 'bavatars', testBavatars),
              ),
        ],
      );
    });
  });
}
