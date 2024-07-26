import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/game_controller.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class GameScreen extends StatelessWidget {
  final GameController controller = Get.put(GameController());

  GameScreen({super.key});

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
                _buildScoreBoard(),
                const SizedBox(height: 30),
                _buildQuestion(),
                const SizedBox(height: 40),
                _buildAnswerBoxes(),
                const SizedBox(height: 30),
                _buildActionButtons(),
                const Spacer(),
                _buildLetterOptions(),
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

  Widget _buildScoreBoard() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildScoreItem(
                Icons.question_mark, 'Savol', '${controller.hints.value}'),
            _buildScoreItem(Icons.star, 'Score', '${controller.score.value}'),
            _buildScoreItem(
                Icons.diamond, 'Olmoslar', '${controller.diamonds.value}'),
          ],
        ));
  }

  Widget _buildScoreItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 14)),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildQuestion() {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            controller
                .questions[controller.currentQuestionIndex.value].questionText,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ));
  }

  Widget _buildAnswerBoxes() {
    return Obx(
      () => Wrap(
        alignment: WrapAlignment.center,
        spacing: 3,
        runSpacing: 3,
        children: List.generate(
          controller
              .questions[controller.currentQuestionIndex.value].answer.length,
          (index) => Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Obx(() => FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    controller.selectedLetters.value.length > index
                        ? controller.selectedLetters.value[index]
                        : '',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
            Icons.backspace, 'Delete', () => controller.deleteLastLetter()),
        _buildActionButton(
            Icons.diamond, 'Hint (10)', () => controller.useDiamondsForHint()),
      ],
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, VoidCallback onPressed) {
    return ZoomTapAnimation(
      onTap: onPressed,
      enableLongTapRepeatEvent: false,
      longTapRepeatDuration: const Duration(milliseconds: 100),
      begin: 1.0,
      end: 0.93,
      beginDuration: const Duration(milliseconds: 20),
      endDuration: const Duration(milliseconds: 120),
      beginCurve: Curves.decelerate,
      endCurve: Curves.fastOutSlowIn,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildLetterOptions() {
    return Obx(() => Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: controller.letterOptions
              .map((letter) => ZoomTapAnimation(
                    onTap: () => controller.selectLetter(letter),
                    enableLongTapRepeatEvent: false,
                    longTapRepeatDuration: const Duration(milliseconds: 100),
                    begin: 1.0,
                    end: 0.93,
                    beginDuration: const Duration(milliseconds: 20),
                    endDuration: const Duration(milliseconds: 120),
                    beginCurve: Curves.decelerate,
                    endCurve: Curves.fastOutSlowIn,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        letter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ));
  }
}
