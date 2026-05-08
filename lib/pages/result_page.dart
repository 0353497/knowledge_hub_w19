import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:knowledge_hub/models/question.dart';
import 'package:knowledge_hub/pages/homepage.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    super.key,
    required this.icon,
    required this.title,
    required this.selectedAnswers,
    required this.questions,
  });
  final IconData icon;
  final String title;
  final List<String> selectedAnswers;
  final List<Question> questions;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int get result {
    int score = 100;
    for (var i = 0; i < 4; i++) {
      if (widget.questions[i].answer != widget.selectedAnswers[i]) score -= 25;
    }
    return score;
  }

  bool isCorrect(int index) {
    return widget.questions[index].answer == widget.selectedAnswers[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 24,
            children: [
              Row(children: [Icon(widget.icon), Text(widget.title)]),
              Text("Result"),
              Text("$result"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text("Your Answer"), Text("Correct Answer")],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      for (var i = 0; i < 4; i++)
                        Text(
                          widget.selectedAnswers[i],
                          style: TextStyle(
                            color: isCorrect(i) ? null : Colors.red,
                          ),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      for (var i = 0; i < 4; i++)
                        Text(
                          widget.questions[i].answer,
                          style: TextStyle(color: Colors.blue),
                        ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => Homepage());
                },
                child: Text("Exit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
