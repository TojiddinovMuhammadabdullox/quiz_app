import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/game_cubit.dart';
import 'package:quiz_app/blocs/game_state.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade400,
              Colors.purple.shade400,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                _buildAppBar(),
                const SizedBox(height: 20),
                _buildScoreBoard(context),
                const SizedBox(height: 20),
                _buildQuestion(context),
                const SizedBox(height: 20),
                _buildAnswerBoxes(context),
                const SizedBox(height: 20),
                _buildActionButtons(context),
                const Spacer(),
                _buildLetterOptions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return const Text(
      "So'zni toping",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 28,
      ),
    );
  }

  Widget _buildScoreBoard(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildScoreItem(Icons.question_mark, 'Savollar',
                '${state.currentQuestionIndex + 1}/${state.questions.length}'),
            _buildScoreItem(Icons.diamond, 'Olmoslar', '${state.diamonds}'),
            _buildScoreItem(Icons.help, 'Savollar', '${state.hints}'),
          ],
        );
      },
    );
  }

  Widget _buildScoreItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildQuestion(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Container(
          height: 250,
          width: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              state.questions[state.currentQuestionIndex].questionText,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnswerBoxes(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final int answerLength =
            state.questions[state.currentQuestionIndex].answer.length;
        return LayoutBuilder(
          builder: (context, constraints) {
            final double boxWidth =
                (constraints.maxWidth - (answerLength - 1) * 8) / answerLength;
            final double boxSize = boxWidth > 35 ? 35 : boxWidth;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                answerLength,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      width: boxSize,
                      height: boxSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          index < state.selectedLetters.length
                              ? state.selectedLetters[index]
                              : '',
                          style: TextStyle(
                            fontSize: boxSize * 0.6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ZoomTapAnimation(
          onTap: () => context.read<GameCubit>().deleteLastLetter(),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.backspace, color: Colors.red, size: 30),
            ),
          ),
        ),
        const SizedBox(width: 20),
        ZoomTapAnimation(
          onTap: () => context.read<GameCubit>().useDiamondsForHint(),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.lightbulb, color: Colors.yellow, size: 30),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLetterOptions(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 6,
          runSpacing: 6,
          children: state.letterOptions.map((letter) {
            return ZoomTapAnimation(
              onTap: () => context.read<GameCubit>().selectLetter(letter),
              child: Container(
                width: 55,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    letter,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
