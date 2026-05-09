// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:knowledge_hub/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("app test", (tester) async {
    int currentStep = 1;

    Future<void> nextStep(String description) async {
      print("Step No: $currentStep,$description");
      await Future.delayed(Duration(seconds: 10));
      await tester.pumpAndSettle();
      currentStep++;
    }

    Future<void> selectQuestionAndNext(String value) async {
      await tester.tap(find.byKey(ValueKey(value)));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Next"));
      await tester.pumpAndSettle();
    }

    await tester.pumpWidget(MainApp());
    await tester.pumpAndSettle();
    await nextStep("Launch the app.");

    await tester.tap(find.text("Management"));
    await tester.pumpAndSettle();
    await nextStep("Select the first knowledge item from the Home Page.");

    await nextStep("Play the first educational video on the Content Page. ");
    await tester.tap(find.text("Play"));
    await tester.pumpAndSettle();
    await Future.delayed(Duration(milliseconds: 5000));

    await tester.tap(find.text("Pause"));
    await tester.pumpAndSettle();
    await Future.delayed(Duration(milliseconds: 2500));

    await tester.tap(find.text("Replay"));
    await tester.pumpAndSettle();
    await Future.delayed(Duration(milliseconds: 2500));

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    await nextStep(
      "Complete the quiz on the Quiz Page (for the first knowledge item).",
    );

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();
    Future.delayed(Duration(seconds: 2));

    await selectQuestionAndNext("A");
    await selectQuestionAndNext("A");
    await selectQuestionAndNext("B");

    await tester.tap(find.byKey(ValueKey("D")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Submit"));
    await tester.pumpAndSettle();

    expect(find.text("100"), findsOneWidget);
    await nextStep("Review the score and answer summary on the Results Page.");

    await tester.tap(find.text("Exit"));
    await tester.pumpAndSettle();

    await nextStep("Select the second knowledge item from the Home Page.");
    await tester.tap(find.text("About the Venue"));
    await tester.pumpAndSettle();

    await nextStep("Play the second educational video on the Content Page.");
    await tester.tap(find.text("Play"));
    await tester.pumpAndSettle();

    await Future.delayed(Duration(seconds: 50));
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    await nextStep(
      "Complete the quiz on the Quiz Page (for the second knowledge item).",
    );

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();
    Future.delayed(Duration(seconds: 2));

    await selectQuestionAndNext("D");
    await selectQuestionAndNext("D");
    await selectQuestionAndNext("B");

    await tester.tap(find.byKey(ValueKey("C")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Submit"));
    await tester.pumpAndSettle();

    expect(find.text("75"), findsOneWidget);
    await nextStep(
      "Review the score and answer summary on the Results Page for second knowledge item.",
    );

    await tester.tap(find.text("Exit"));
    await tester.pumpAndSettle();

    await nextStep("Select the third knowledge item from the Home Page.");
    await tester.tap(find.text("Public Art"));
    await tester.pumpAndSettle();

    await nextStep("Play the third educational video on the Content Page.");
    await tester.tap(find.text("Play"));
    await tester.pumpAndSettle();

    await Future.delayed(Duration(seconds: 50));
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    await nextStep(
      "Complete the quiz on the Quiz Page (for the third knowledge item).",
    );

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();
    Future.delayed(Duration(seconds: 2));

    await selectQuestionAndNext("B");
    await selectQuestionAndNext("C");
    await selectQuestionAndNext("D");

    await tester.tap(find.byKey(ValueKey("A")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Submit"));
    await tester.pumpAndSettle();

    expect(find.text("0"), findsOneWidget);
    await nextStep(
      "Review the score and answer summary on the Results Page for third knowledge item.",
    );

    await tester.tap(find.text("Exit"));
    await tester.pumpAndSettle();

    await nextStep("Select the fourth knowledge item from the Home Page.");
    await tester.tap(find.text("Facilities"));
    await tester.pumpAndSettle();

    await nextStep("Play the fourth educational video on the Content Page.");
    await tester.tap(find.text("Play"));
    await tester.pumpAndSettle();

    await Future.delayed(Duration(seconds: 54));
    await tester.tap(find.text("Replay"));
    await tester.pumpAndSettle();
    await Future.delayed(Duration(milliseconds: 2500));

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    await nextStep(
      "Complete the quiz on the Quiz Page (for the fourth knowledge item).",
    );

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();
    Future.delayed(Duration(seconds: 2));

    await selectQuestionAndNext("A");
    await selectQuestionAndNext("C");
    await selectQuestionAndNext("B");

    await tester.tap(find.byKey(ValueKey("D")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Submit"));
    await tester.pumpAndSettle();

    expect(find.text("50"), findsOneWidget);
    await nextStep(
      "Review the score and answer summary on the Results Page for fourth knowledge item.",
    );

    await tester.tap(find.text("Exit"));
    await tester.pumpAndSettle();

    await nextStep("Select the fifth knowledge item from the Home Page.");
    await tester.tap(find.text("Dining & Catering"));
    await tester.pumpAndSettle();

    await nextStep("Play the fifth educational video on the Content Page.");
    await tester.tap(find.text("Play"));
    await tester.pumpAndSettle();

    await Future.delayed(Duration(seconds: 110));
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    await nextStep(
      "Complete the quiz on the Quiz Page (for the fifth knowledge item).",
    );

    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();
    Future.delayed(Duration(seconds: 2));

    await selectQuestionAndNext("C");
    await selectQuestionAndNext("D");
    await selectQuestionAndNext("A");

    await tester.tap(find.byKey(ValueKey("B")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Submit"));
    await tester.pumpAndSettle();

    expect(find.text("25"), findsOneWidget);
    await nextStep(
      "Review the score and answer summary on the Results Page for fifth knowledge item.",
    );

    await tester.tap(find.text("Exit"));
    await tester.pumpAndSettle();

    await nextStep("Return to the Home Screen.");
  });
}
