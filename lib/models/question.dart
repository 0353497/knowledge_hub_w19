class Question {
  final String question;
  final String answer;
  final List<String> options;

  int get correctIndex {
    if (answer == "B") return 1;
    if (answer == "C") return 2;
    if (answer == "D") return 3;
    return 0;
  }

  Question({
    required this.question,
    required this.answer,
    required this.options,
  });
}
