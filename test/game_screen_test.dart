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
        // `pumpWidget` yordamida widgetni yuklaydi.
        MaterialApp(
          home: BlocProvider(
            // `BlocProvider` yordamida `GameCubit` ni korsatadi.
            create: (_) => gameCubit,
            child:
                GameScreen(), // Test qilinadigan `GameScreen` widgetini oladi.
          ),
        ),
      );

      final imageFinder = find.byType(Image); //image topadi
      expect(imageFinder, findsNWidgets(4)); //4 ta image bormi yomi tekshiradi

      expect(find.text('Delete'), findsOneWidget); //delete buttonni topadi

      expect(find.text('Hint (10)'),
          findsOneWidget); // olmos ishlatish buttoni topadi  
    });
  });
}
