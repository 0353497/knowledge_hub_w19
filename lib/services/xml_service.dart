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
    if (index < 0 || index >= _xmlFiles.length) return [];
    final xml = await rootBundle.loadString(_xmlFiles[index]);
    final root = XmlDocument.parse(xml).rootElement;
    final List<Question> questions = [];
    final quizzes =
        root.children
            .whereType<XmlElement>()
            .where((e) => e.name.local.startsWith('Quiz_'))
            .toList()
          ..sort((a, b) {
            final ai = int.tryParse(a.name.local.split('_').last) ?? 0;
            final bi = int.tryParse(b.name.local.split('_').last) ?? 0;
            return ai.compareTo(bi);
          });

    for (final quiz in quizzes) {
      final String question =
          quiz.getElement('Question')?.innerText.trim() ?? '';
      final String answer = quiz.getElement('Answer')?.innerText.trim() ?? '';
      final optionsElem = quiz.getElement('Options');
      final List<String> options = optionsElem == null
          ? []
          : optionsElem.children
                .whereType<XmlElement>()
                .map((e) => e.innerText.trim())
                .toList();

      questions.add(
        Question(question: question, answer: answer, options: options),
      );
    }
    return questions;
  }
}
