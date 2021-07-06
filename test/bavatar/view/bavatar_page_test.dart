// ignore_for_file: prefer_const_constructors

import 'package:bavatar/bavatar/bavatar.dart';
import 'package:bavatar/bavatar/models/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bavatar_repository/bavatar_repository.dart' hide Bavatar;
import 'package:bavatar_repository/bavatar_repository.dart'
    as bavatar_repository;

class MockBavatarRepository extends Mock implements BavatarRepository {}

class FakeBavatarState extends Fake implements BavatarState {}

class MockBavatarCubit extends MockCubit<BavatarState> implements BavatarCubit {
}

final bavatar = Bavatar(
  id: 1,
  url: 'mock_url',
  gender: 'male',
  ageRange: '18-25',
  type: BavatarType.casual,
  createdAt: DateTime(2021),
  updatedAt: DateTime(2021),
);

void main() {
  setUpAll(() {
    registerFallbackValue<BavatarState>(FakeBavatarState());
  });

  late BavatarRepository bavatarRepository;

  setUp(() {
    bavatarRepository = MockBavatarRepository();
    when(() => bavatarRepository.getBavatars()).thenAnswer((_) async => [
          bavatar_repository.Bavatar(
            id: 1,
            url: 'mock_url',
            gender: 'male',
            ageRange: '18-25',
            type: BavatarType.casual,
            createdAt: DateTime(2021),
            updatedAt: DateTime(2021),
          )
        ]);
  });

  group('BavatarPage', () {
    testWidgets('renders BavatarView', (tester) async {
      await tester.pumpWidget(RepositoryProvider.value(
        value: bavatarRepository,
        child: MaterialApp(home: BavatarPage()),
      ));
      expect(find.byType(BavatarView), findsOneWidget);
    });
  });

  group('BavatarView', () {
    late BavatarCubit bavatarCubit;

    setUp(() {
      bavatarCubit = MockBavatarCubit();
      when(() => bavatarCubit.fetchBavatars()).thenAnswer((_) async => {});
    });

    testWidgets('renders BavatarEmpty for BavatarStatus.initial',
        (tester) async {
      when(() => bavatarCubit.state).thenReturn(
        BavatarState(
          bavatarsList: BavatarsList(
            bavatars: [bavatar],
          ),
        ),
      );
      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      expect(find.byType(BavatarEmpty), findsOneWidget);
    });

    testWidgets('renders BavatarLoading for BavatarStatus.loading',
        (tester) async {
      when(() => bavatarCubit.state).thenReturn(BavatarState(
        status: BavatarStatus.loading,
      ));
      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      expect(find.byType(BavatarLoading), findsOneWidget);
    });

    testWidgets('renders BavatarPopulated for BavatarStatus.success',
        (tester) async {
      when(() => bavatarCubit.state).thenReturn(BavatarState(
        status: BavatarStatus.success,
        bavatarsList: BavatarsList(bavatars: [bavatar]),
      ));
      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      expect(find.byType(BavatarPopulated), findsOneWidget);
    });

    testWidgets('renders GridView for BavatarStatus.success', (tester) async {
      when(() => bavatarCubit.state).thenReturn(BavatarState(
        status: BavatarStatus.success,
        bavatarsList: BavatarsList(bavatars: [bavatar]),
      ));
      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('renders BavatarPopulated for BavatarStatus.success',
        (tester) async {
      when(() => bavatarCubit.state).thenReturn(BavatarState(
        status: BavatarStatus.success,
        bavatarsList: BavatarsList(bavatars: [bavatar]),
      ));
      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      expect(find.byType(ShaderMask), findsOneWidget);
    });

    testWidgets('renders BavatarError for BavatarStatus.failure',
        (tester) async {
      when(() => bavatarCubit.state).thenReturn(BavatarState(
        status: BavatarStatus.failure,
      ));

      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      expect(find.byType(BavatarError), findsOneWidget);
    });

    testWidgets('renders BackdropFilter in BavatarPopulated', (tester) async {
      when(() => bavatarCubit.state).thenReturn(BavatarState());
      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('renders Bavatar text in BavatarTitle', (tester) async {
      when(() => bavatarCubit.state).thenReturn(BavatarState());
      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Bavatar'), findsOneWidget);
    });

    testWidgets('renders Opacity when search button is tapped', (tester) async {
      when(() => bavatarCubit.state).thenReturn(BavatarState());
      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(Opacity), findsOneWidget);
    });

    testWidgets(
        'findskey '
        '[_BavatarBg, _BavatarUI, _BavatarTitle]'
        ' for BavatarStatus.failure', (tester) async {
      when(() => bavatarCubit.state).thenReturn(BavatarState(
        status: BavatarStatus.failure,
      ));

      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      expect(find.byKey('_BavatarBg'.toKey), findsOneWidget);
      expect(find.byKey('_BavatarUI'.toKey), findsOneWidget);
      expect(find.byKey('_BavatarTitle'.toKey), findsOneWidget);
    });

    testWidgets('refreshBavatar is not called on pull to refresh',
        (tester) async {
      when(() => bavatarCubit.state).thenReturn(BavatarState(
        status: BavatarStatus.success,
        bavatarsList: BavatarsList(bavatars: [bavatar]),
      ));
      when(() => bavatarCubit.refreshBavatars()).thenAnswer((_) async {});
      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      verifyNever(() => bavatarCubit.refreshBavatars());
    });

    testWidgets('fetchBavatars is called on load', (tester) async {
      when(() => bavatarCubit.state).thenReturn(BavatarState(
        status: BavatarStatus.success,
        bavatarsList: BavatarsList(bavatars: [bavatar]),
      ));
      await tester.pumpWidget(BlocProvider.value(
        value: bavatarCubit,
        child: MaterialApp(home: BavatarView()),
      ));
      verify(() => bavatarCubit.fetchBavatars()).called(1);
    });
  });
}

extension on String {
  Key get toKey => Key(this);
}
