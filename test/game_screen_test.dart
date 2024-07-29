import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/blocs/game_cubit.dart';
import 'package:quiz_app/views/game_screen.dart';

void main() {
  group('GameScreen Widget Test', () {
    late GameCubit gameCubit;

    setUp(() {
      gameCubit = GameCubit();
    });

    testWidgets('should display 4 images and buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => gameCubit,
            child: GameScreen(),
          ),
        ),
      );

      // Verify 4 images are displayed
      final imageFinder = find.byType(Image);
      expect(imageFinder, findsNWidgets(4));

      // Verify Delete button is displayed
      expect(find.text('Delete'), findsOneWidget);

      // Verify Hint button is displayed
      expect(find.text('Hint (10)'), findsOneWidget);
    });
  });
}
