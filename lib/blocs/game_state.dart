import 'package:equatable/equatable.dart';
import 'package:quiz_app/model/question.dart';

class GameState extends Equatable {
  final List<Question> questions;
  final int currentQuestionIndex;
  final String selectedLetters;
  final int score;
  final int hints;
  final int diamonds;
  final int correctAnswers;
  final int incorrectAnswers;
  final List<String> letterOptions;

  const GameState({
    required this.questions,
    required this.currentQuestionIndex,
    required this.selectedLetters,
    required this.score,
    required this.hints,
    required this.diamonds,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.letterOptions,
  });

  GameState copyWith({
    List<Question>? questions,
    int? currentQuestionIndex,
    String? selectedLetters,
    int? score,
    int? hints,
    int? diamonds,
    int? correctAnswers,
    int? incorrectAnswers,
    List<String>? letterOptions,
  }) {
    return GameState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedLetters: selectedLetters ?? this.selectedLetters,
      score: score ?? this.score,
      hints: hints ?? this.hints,
      diamonds: diamonds ?? this.diamonds,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers,
      letterOptions: letterOptions ?? this.letterOptions,
    );
  }

  @override
  List<Object?> get props => [
        questions,
        currentQuestionIndex,
        selectedLetters,
        score,
        hints,
        diamonds,
        correctAnswers,
        incorrectAnswers,
        letterOptions,
      ];

  static initial() {}
}
