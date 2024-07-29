import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:quiz_app/blocs/game_cubit.dart';
import 'package:quiz_app/blocs/game_state.dart';

void main() {
  group('GameCubit Unit Test', () {
    late GameCubit gameCubit;

    setUp(() {
      gameCubit = GameCubit();
    });

    tearDown(() {
      gameCubit.close();
    });

    test('initial state is GameState', () {
      expect(gameCubit.state, GameState.initial());
    });

    blocTest<GameCubit, GameState>(
      'emits correct states when selectLetter is called with correct answer',
      build: () => gameCubit,
      act: (cubit) {
        cubit.selectLetter('Q');
        cubit.selectLetter('U');
        cubit.selectLetter('M');
      },
      expect: () => [
        isA<GameState>(),
        isA<GameState>(),
        isA<GameState>(),
      ],
    );

    blocTest<GameCubit, GameState>(
      'emits correct states when deleteLastLetter is called',
      build: () => gameCubit,
      act: (cubit) {
        cubit.selectLetter('Q');
        cubit.deleteLastLetter();
      },
      expect: () => [
        isA<GameState>(),
      ],
    );

    blocTest<GameCubit, GameState>(
      'emits correct states when useDiamondsForHint is called',
      build: () => gameCubit,
      act: (cubit) {
        cubit.useDiamondsForHint();
      },
      expect: () => [
        isA<GameState>(),
      ],
    );

    blocTest<GameCubit, GameState>(
      'emits correct states when nextQuestion is called',
      build: () => gameCubit,
      act: (cubit) {
        cubit.nextQuestion();
      },
      expect: () => [
        isA<GameState>(),
      ],
    );
  });
}
