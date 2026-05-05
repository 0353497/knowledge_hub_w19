import 'package:flutter/services.dart';
import 'package:knowledge_hub/models/question.dart';
import 'package:xml/xml.dart';

class XmlService {
  static const List<String> _xmlFiles = [
    "assets/media-files/K1_Management/Knowledge1.xml",
    "assets/media-files/K2_About_the_Venue/Knowledge2.xml",
    "assets/media-files/K3_Public_Art/Knowledge3.xml",
    "assets/media-files/K4_Facilities/Knowledge4.xml",
    "assets/media-files/K5_Dining&Catering/Knowledge5.xml",
  ];

  static Future<List<Question>> loadQuestions(int index) async {
    final xml = await rootBundle.loadString(_xmlFiles[index]);
    final root = XmlDocument.parse(xml).root;
    final List<Question> questions = [];
    for (var i = 1; i <= 4; i++) {
      final XmlElement quiz = root.getElement("Quiz_$i")!;
      final String question = quiz.getElement("Question")?.value ?? "";
      final String answer = quiz.getElement("Answer")?.value ?? "";
      final List<String> options = quiz
          .findAllElements("Options")
          .map((element) => element.value ?? "")
          .toList();
      questions.add(
        Question(question: question, answer: answer, options: options),
      );
    }
    return questions;
  }
}
