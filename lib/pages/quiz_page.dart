import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:knowledge_hub/models/question.dart';
import 'package:knowledge_hub/pages/result_page.dart';
import 'package:knowledge_hub/services/xml_service.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
    required this.index,
    required this.icon,

    required this.title,
  });
  @override
  State<QuizPage> createState() => _QuizPageState();

  final int index;
  final IconData icon;
  final String title;
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;

  late List<Question> questions = [];
  List<String> selectedAnswers = ["", "", "", ""];
  bool isLoading = true;
  String? selectedAnswer;
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(children: [Icon(widget.icon), Text(widget.title)]),
            Text(
              "Quiz ${currentQuestion + 1}",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            if (isLoading) Center(child: CircularProgressIndicator()),
            if (!isLoading)
              Column(
                children: [
                  Text(questions[currentQuestion].question),
                  RadioGroup<String>(
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value;
                      });
                    },
                    child: Column(
                      children: List<Widget>.generate(
                        questions[currentQuestion].options.length,
                        (i) {
                          final letter = String.fromCharCode(65 + i);
                          final optionText =
                              questions[currentQuestion].options[i];
                          return RadioListTile<String>(
                            title: Text(optionText),
                            value: letter,
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (currentQuestion == 0) {
                            Get.back();
                          } else {
                            setState(() {
                              currentQuestion--;
                            });
                          }
                        },
                        child: Text("Back"),
                      ),
                      ElevatedButton(
                        onPressed:
                            currentQuestion == 3 && selectedAnswer == null
                            ? null
                            : () {
                                if (currentQuestion == 3) {
                                  selectedAnswers[currentQuestion] =
                                      selectedAnswer!;
                                  Get.to(
                                    () => ResultPage(
                                      icon: widget.icon,
                                      title: widget.title,
                                      selectedAnswers: selectedAnswers,
                                      questions: questions,
                                    ),
                                  );
                                } else {
                                  if (selectedAnswer == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Question Unanswered"),
                                      ),
                                    );
                                    return;
                                  }
                                  selectedAnswers[currentQuestion] =
                                      selectedAnswer!;
                                  setState(() {
                                    selectedAnswer = null;
                                    currentQuestion++;
                                  });
                                }
                              },
                        child: Text(
                          currentQuestion == 3 ? "Submit" : "Next Question",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void init() async {
    questions = await XmlService.loadQuestions(widget.index);
    setState(() {
      isLoading = false;
    });
  }
}
