// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:knowledge_hub/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("app test", (tester) async {
    int currentStep = 1;

    Future<void> nextStep(String description) async {
      print("Step No: $currentStep,$description of the Action");
      await Future.delayed(Duration(seconds: 10));
      await tester.pumpAndSettle();
      currentStep++;
    }

    await tester.pumpWidget(MainApp());
    await tester.pumpAndSettle();
    await nextStep("Launch the app.");

    await tester.tap(find.text("Management"));
    await tester.pumpAndSettle();
    await nextStep("Select the first knowledge item from the Home Page.");
  });
}
