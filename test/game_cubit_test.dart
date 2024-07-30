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
      gameCubit.close(); // 'GameCubit'ni yopadi
    });

    test('initial state is GameState', () {
      expect(gameCubit.state, GameState.initial());
    });
    blocTest<GameCubit, GameState>(
      'emits correct states when selectLetter is called with correct answer', // Testning nomi.
      build: () => gameCubit, // 'GameCubit ni yaratadi.
      act: (cubit) {
        cubit.selectLetter('Q'); // Harfni tanlash.
        cubit.selectLetter('U');
        cubit.selectLetter('M');
      },
      expect: () => [
        isA<GameState>(), // Har bir harf tanlanganda yangi holatni emit "setState" qiladi.
        isA<GameState>(),
        isA<GameState>(),
      ],
    );
    blocTest<GameCubit, GameState>(
      'emits correct states when deleteLastLetter is called',
      build: () => gameCubit,
      act: (cubit) {
        cubit.selectLetter('Q');
        cubit.deleteLastLetter(); // Tanlangan harfni o'chirish.
      },
      expect: () => [
        isA<GameState>(), // Harf o'chirilganda yangi holatni  emit "setState" qiladi.
      ],
    );
    blocTest<GameCubit, GameState>(
      'emits correct states when useDiamondsForHint is called',
      build: () => gameCubit,
      act: (cubit) {
        cubit.useDiamondsForHint(); //   olmosdan foydalanish.
      },
      expect: () => [
        isA<GameState>(), // yangi holatni setState qiladi.
      ],
    );
    blocTest<GameCubit, GameState>(
      'emits correct states when nextQuestion is called',
      build: () => gameCubit, 
      act: (cubit) {
        cubit.nextQuestion(); // Keyingi savolga o'tish.
      },
      expect: () => [
        isA<GameState>(), // Keyingi savolga o'tganda yangi holatni emit qiladi.
      ],
    );
  });
}
