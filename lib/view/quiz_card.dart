import 'package:agham_tales/model/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/story_controller.dart';
import '../model/quiz.dart';

class QuizCard extends StatefulWidget {
  final String book;
  final String title;

  const QuizCard({super.key, required this.book, required this.title});

  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool showFeedback = false;
  int score = 0;
  late List<Quiz> quizzes;
  late String _keyPrefix;

  @override
  void initState() {
    _keyPrefix = 'book_${widget.title.hashCode}';
    super.initState();
    _initQuiz();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _initQuiz() async {
    final book = await BookController().loadBookState(_keyPrefix);
    setState(() {
      quizzes = book.quizzes;
    });
  }

  void handleAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showFeedback = true;
      if (answer == quizzes[currentQuestionIndex].correctAnswer) {
        score++;
      }
    });
  }

  void handleNext() {
    setState(() {
      if (currentQuestionIndex < quizzes.length - 1) {
        currentQuestionIndex++;
        selectedAnswer = null;
        showFeedback = false;
      } else {
        saveQuizScore(score);
      }
    });
  }

  void handleTryAgain() {
    print(_keyPrefix);
    saveQuizScore(score);
    Navigator.popAndPushNamed(
      context,
      "/home",
    );
  }

  Future<void> saveQuizScore(int score) async {
    await BookController().saveQuizScore(_keyPrefix, score);
    print(BookController().getQuizScore(_keyPrefix));
    final String? nextBook =
        await BookController().getNextBookKeyPrefix(_keyPrefix);
    await BookController().unlockNextBook(nextBook!);
  }

  @override
  Widget build(BuildContext context) {
    if (quizzes == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQuiz = quizzes[currentQuestionIndex];
    final isCorrect = selectedAnswer == currentQuiz.correctAnswer;
    final isLastQuestion = currentQuestionIndex == quizzes.length - 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '${widget.title} Quiz',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Question ${currentQuestionIndex + 1} of ${quizzes.length}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Score: $score',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value:
                              (currentQuestionIndex + 1) / quizzes.length,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.blue),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          currentQuiz.question,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ...currentQuiz.choices.entries.map((entry) {
                          final choiceKey = entry.key;
                          final choiceText = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              child: ElevatedButton(
                                child: Text(
                                  '$choiceKey. $choiceText',
                                  style: const TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      selectedAnswer == choiceKey
                                          ? (isCorrect
                                              ? Colors.green
                                              : Colors.red)
                                          : Colors.blue,
                                  minimumSize:
                                      const Size(double.infinity, 60),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: selectedAnswer == null
                                    ? () => handleAnswer(choiceKey)
                                    : null,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      selectedAnswer == null
                          ? 'Select the best answer and tap "Next" to continue.'
                          : (isCorrect
                              ? currentQuiz.correctFeedback
                              : currentQuiz.incorrectFeedback),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: showFeedback
          ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 38.0),
            child: FloatingActionButton.extended(
                onPressed: isLastQuestion ? handleTryAgain : handleNext,
                label: Text(isLastQuestion ? 'Go back to home' : 'Next'),
                icon: Icon(
                    isLastQuestion ? LucideIcons.home : LucideIcons.arrowRight),
              ),
          )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
