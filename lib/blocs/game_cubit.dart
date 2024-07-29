import 'package:bloc/bloc.dart';
import 'package:quiz_app/blocs/game_state.dart';
import 'dart:math';

import '../model/question.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
      : super(GameState(
          questions: [
            Question(
                'https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/5/37.webp?v=1682812404',
                'QUM'),
            Question(
                'https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/5/53.webp?v=1682812404',
                'HAVORANG'),
            Question(
                'https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/6/3.webp?v=1682812404',
                'OYNA'),
            Question(
                'https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/6/1.webp?v=1682812404',
                'ASHULA'),
          ],
          currentQuestionIndex: 0,
          selectedLetters: '',
          score: 0,
          hints: 0,
          diamonds: 50,
          correctAnswers: 0,
          incorrectAnswers: 0,
          letterOptions: const [],
        )) {
    loadQuestion();
  }

  void loadQuestion() {
    var answer = state.questions[state.currentQuestionIndex].answer;
    var randomLetters = 'ABDEFGHIJKLMNOPQRSTUVWXYZ';
    var rng = Random();
    List<String> letterOptions = answer.split('');
    while (letterOptions.length < 10) {
      var randomLetter = randomLetters[rng.nextInt(randomLetters.length)];
      if (!letterOptions.contains(randomLetter)) {
        letterOptions.add(randomLetter);
      }
    }
    letterOptions.shuffle();
    emit(state.copyWith(letterOptions: letterOptions));
  }

  void selectLetter(String letter) {
    if (state.selectedLetters.length <
        state.questions[state.currentQuestionIndex].answer.length) {
      String updatedLetters = state.selectedLetters + letter;
      emit(state.copyWith(selectedLetters: updatedLetters));
      if (updatedLetters.length ==
          state.questions[state.currentQuestionIndex].answer.length) {
        checkAnswer(updatedLetters);
      }
    }
  }

  void deleteLastLetter() {
    if (state.selectedLetters.isNotEmpty) {
      String updatedLetters =
          state.selectedLetters.substring(0, state.selectedLetters.length - 1);
      emit(state.copyWith(selectedLetters: updatedLetters));
    }
  }

  void checkAnswer(String selectedLetters) {
    if (selectedLetters == state.questions[state.currentQuestionIndex].answer) {
      int updatedScore = state.score + 10;
      int updatedCorrectAnswers = state.correctAnswers + 1;
      emit(state.copyWith(
        score: updatedScore,
        correctAnswers: updatedCorrectAnswers,
      ));
      nextQuestion();
    } else {
      int updatedIncorrectAnswers = state.incorrectAnswers + 1;
      emit(state.copyWith(incorrectAnswers: updatedIncorrectAnswers));
      // Show dialog or other UI feedback for incorrect answer
    }
  }

  void nextQuestion() {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      int updatedIndex = state.currentQuestionIndex + 1;
      emit(state.copyWith(
        currentQuestionIndex: updatedIndex,
        selectedLetters: '',
      ));
      loadQuestion();
    } else {
      // Show game results
      // Reset game or show final results
    }
  }

  void resetGame() {
    emit(state.copyWith(
      currentQuestionIndex: 0,
      score: 0,
      correctAnswers: 0,
      incorrectAnswers: 0,
      selectedLetters: '',
    ));
    loadQuestion();
  }

  void useDiamondsForHint() {
    if (state.diamonds >= 10) {
      int updatedDiamonds = state.diamonds - 10;
      var answer = state.questions[state.currentQuestionIndex].answer;
      String updatedLetters = state.selectedLetters;
      for (int i = 0; i < answer.length; i++) {
        if (i >= updatedLetters.length || updatedLetters[i] != answer[i]) {
          updatedLetters = updatedLetters.substring(0, i) +
              answer[i] +
              updatedLetters.substring(i);
          break;
        }
      }
      emit(state.copyWith(
          selectedLetters: updatedLetters, diamonds: updatedDiamonds));
      if (updatedLetters.length == answer.length) {
        checkAnswer(updatedLetters);
      }
    } else {
      // Show snackbar or other UI feedback for insufficient diamonds
    }
  }
}
