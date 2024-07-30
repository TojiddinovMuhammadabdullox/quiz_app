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
    var answer = state.questions[state.currentQuestionIndex]
        .answer; //  savolning javobini oladi.
    var randomLetters = 'ABDEFGHIJKLMNOPQRSTUVWXYZ'; // random harflar ro'yxati.
    var rng = Random(); // random sonlar generatori.
    List<String> letterOptions =
        answer.split(''); // Javobdagi harflarni ro'yxatga aylantiradi.  // spliy harflarni alohida olish uchun
    while (letterOptions.length < 10) {
      var randomLetter = randomLetters[
          rng.nextInt(randomLetters.length)]; // random harf oladi.
      if (!letterOptions.contains(randomLetter)) {
        letterOptions
            .add(randomLetter); // Agar bu harf ro'yxatda bo'lmasa, qo'shadi.
      }
    }
    letterOptions.shuffle(); // Harflarni random   aralashtiradi.
    emit(state.copyWith(
        letterOptions: letterOptions)); // Yangi holatni emit qiladi.
  }

  void selectLetter(String letter) {
    if (state.selectedLetters.length <
        state.questions[state.currentQuestionIndex].answer.length) {
      String updatedLetters =
          state.selectedLetters + letter; // Tanlangan harfni qo'shadi.
      emit(state.copyWith(
          selectedLetters: updatedLetters)); // Yangi holatni emit qiladi.
      if (updatedLetters.length ==
          state.questions[state.currentQuestionIndex].answer.length) {
        checkAnswer(
            updatedLetters); // Agar tanlangan harflar soni javob uzunligiga teng bo'lsa, javobni tekshiradi.
      }
    }
  }

  void deleteLastLetter() {
    if (state.selectedLetters.isNotEmpty) {
      String updatedLetters = state.selectedLetters.substring(
          0, state.selectedLetters.length - 1); // Oxirgi harfni olib tashlaydi.
      emit(state.copyWith(
          selectedLetters:
              updatedLetters)); // Yangi holatni emit "setState" qiladi.
    }
  }

  void checkAnswer(String selectedLetters) {
    if (selectedLetters == state.questions[state.currentQuestionIndex].answer) {
      int updatedScore = state.score + 10; // To'g'ri javob uchun ball qo'shadi.
      int updatedCorrectAnswers =
          state.correctAnswers + 1; // To'g'ri javoblar sonini oshiradi.
      emit(state.copyWith(
        score: updatedScore,
        correctAnswers: updatedCorrectAnswers,
      ));
      nextQuestion(); // Keyingi savolga o'tadi.
    } else {
      int updatedIncorrectAnswers =
          state.incorrectAnswers + 1; // Noto'g'ri javoblar sonini oshiradi.
      emit(state.copyWith(incorrectAnswers: updatedIncorrectAnswers));
    }
  }

  void nextQuestion() {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      int updatedIndex =
          state.currentQuestionIndex + 1; // Joriy savol indeksini oshiradi.
      emit(state.copyWith(
        currentQuestionIndex: updatedIndex,
        selectedLetters: '',
      ));
      loadQuestion(); // Yangi savolni yuklaydi.
    } else {}
  }

  void resetGame() {
    emit(state.copyWith(
      currentQuestionIndex: 0,
      score: 0,
      correctAnswers: 0,
      incorrectAnswers: 0,
      selectedLetters: '',
    ));
    loadQuestion(); // O'yinni qayta boshlaydi va yangi savolni yuklaydi.
  }

  void useDiamondsForHint() {
    if (state.diamonds >= 10) {
      int updatedDiamonds = state.diamonds - 10; // 10 olmos kamaytiradi.
      var answer = state.questions[state.currentQuestionIndex]
          .answer; // Joriy savolning javobini oladi.
      String updatedLetters = state.selectedLetters;
      for (int i = 0; i < answer.length; i++) {
        if (i >= updatedLetters.length || updatedLetters[i] != answer[i]) {
          updatedLetters = updatedLetters.substring(0, i) +
              answer[i] +
              updatedLetters.substring(
                  i); // yordam  birinchi mos kelmagan harfni qo'shadi.
          break;
        }
      }
      emit(state.copyWith(
          selectedLetters: updatedLetters,
          diamonds: updatedDiamonds)); // Yangi holatni emit qiladi.
      if (updatedLetters.length == answer.length) {
        checkAnswer(
            updatedLetters); // Agar qo'shilgan harflar to'g'ri javob bilan teng bo'lsa, javobni tekshiradi.
      }
    } else {}
  }
}
