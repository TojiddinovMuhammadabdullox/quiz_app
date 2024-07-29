// import 'package:get/get.dart';
// import 'dart:math';

// import 'package:quiz_app/model/question.dart';

// class GameController extends GetxController {
//   var questions = <Question>[
//     Question(
//         'https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/5/37.webp?v=1682812404',
//         'QUM'),
//     Question(
//         'https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/5/53.webp?v=1682812404',
//         'HAVORANG'),
//     Question(
//         'https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/6/3.webp?v=1682812404',
//         'OYNA'),
//     Question(
//         'https://bygame.ru/uploads/ai/4-fotki-1-slovo-new/6/1.webp?v=1682812404',
//         'ASHULA'),
//   ].obs;

//   var currentQuestionIndex = 0.obs;
//   var selectedLetters = ''.obs;
//   var score = 0.obs;
//   var hints = 0.obs;
//   var diamonds = 50.obs;
//   var correctAnswers = 0.obs;
//   var incorrectAnswers = 0.obs; 
//   var letterOptions = <String>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadQuestion();
//   }

//   void loadQuestion() {
//     var answer = questions[currentQuestionIndex.value].answer;
//     var randomLetters = 'ABDEFGHIJKLMNOPQRSTUVWXYZ';
//     var rng = Random();
//     letterOptions.clear();
//     letterOptions.addAll(answer.split(''));
//     while (letterOptions.length < 10) {
//       var randomLetter = randomLetters[rng.nextInt(randomLetters.length)];
//       if (!letterOptions.contains(randomLetter)) {
//         letterOptions.add(randomLetter);
//       }
//     }
//     letterOptions.shuffle();
//   }

//   void selectLetter(String letter) {
//     if (selectedLetters.value.length <
//         questions[currentQuestionIndex.value].answer.length) {
//       selectedLetters.value += letter;
//       if (selectedLetters.value.length ==
//           questions[currentQuestionIndex.value].answer.length) {
//         checkAnswer();
//       }
//     }
//   }

//   void deleteLastLetter() {
//     if (selectedLetters.value.isNotEmpty) {
//       selectedLetters.value =
//           selectedLetters.value.substring(0, selectedLetters.value.length - 1);
//     }
//   }

//   void checkAnswer() {
//     if (selectedLetters.value == questions[currentQuestionIndex.value].answer) {
//       score.value += 10;
//       correctAnswers.value += 1;
//       nextQuestion();
//     } else {
//       incorrectAnswers.value += 1;
//       Get.defaultDialog(
//         title: 'Noto\'g\'ri javob',
//         middleText: 'Javob noto\'g\'ri!',
//         onConfirm: () {
//           Get.back();
//           selectedLetters.value = '';
//         },
//         textConfirm: 'OK',
//       );
//     }
//   }

//   void nextQuestion() {
//     if (currentQuestionIndex.value < questions.length - 1) {
//       currentQuestionIndex.value++;
//       selectedLetters.value = '';
//       loadQuestion();
//     } else {
//       // Show game results
//       Get.defaultDialog(
//         title: 'O\'yin yakunlandi',
//         middleText:
//             'To\'g\'ri javoblar: ${correctAnswers.value}\nNoto\'g\'ri javoblar: ${incorrectAnswers.value}',
//         textConfirm: 'Qayta o\'ynash',
//         onConfirm: () {
//           Get.back();
//           resetGame();
//         },
//       );
//     }
//   }

//   void resetGame() {
//     currentQuestionIndex.value = 0;
//     score.value = 0;
//     correctAnswers.value = 0;
//     incorrectAnswers.value = 0;
//     selectedLetters.value = '';
//     loadQuestion();
//   }

//   void useDiamondsForHint() {
//     if (diamonds.value >= 10) {
//       diamonds.value -= 10;
//       var answer = questions[currentQuestionIndex.value].answer;
//       for (int i = 0; i < answer.length; i++) {
//         if (i >= selectedLetters.value.length ||
//             selectedLetters.value[i] != answer[i]) {
//           selectedLetters.value = selectedLetters.value.substring(0, i) +
//               answer[i] +
//               selectedLetters.value.substring(i);
//           if (selectedLetters.value.length == answer.length) {
//             checkAnswer();
//           }
//           break;
//         }
//       }
//     } else {
//       Get.snackbar('Diqqat', 'Yetarli miqdorda diamond yo\'q');
//     }
//   }
// }
