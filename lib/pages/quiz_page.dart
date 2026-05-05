import 'package:flutter/material.dart';
import 'package:knowledge_hub/models/question.dart';
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
              "Quiz ${currentQuestion++}",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void init() async {
    questions = await XmlService.loadQuestions(widget.index);
    setState(() {});
  }
}
