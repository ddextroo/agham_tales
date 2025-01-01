class Quiz {
  final String question;
  final Map<String, String> choices;
  final String correctFeedback;
  final String incorrectFeedback;
  final String correctAnswer;

  Quiz(
      {required this.question, required this.choices, required this.correctFeedback, required this.incorrectFeedback, required this.correctAnswer});
}