class Quiz {
  final String? scene;
  final String question;
  final Map<String, String> choices;
  final String correctFeedback;
  final String incorrectFeedback;
  final List<String> correctAnswer;
  final String? reward;

  Quiz(
      {this.scene, required this.question, required this.choices, required this.correctFeedback, required this.incorrectFeedback, required this.correctAnswer, this.reward});
}