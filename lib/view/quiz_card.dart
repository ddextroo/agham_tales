import 'package:agham_tales/model/book.dart';
import 'package:flutter/material.dart';
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple[100]!, Colors.pink[100]!, Colors.red[100]!],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.purple, Colors.pink],
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Text(
                          'Fun Science Quiz',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                                  Colors.purple),
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
                                      style: const TextStyle(fontSize: 18),
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
        ),
      ),
      floatingActionButton: showFeedback
          ? FloatingActionButton.extended(
              onPressed: isLastQuestion ? handleTryAgain : handleNext,
              label: Text(isLastQuestion ? 'Go back to home' : 'Next'),
              icon: Icon(
                  isLastQuestion ? LucideIcons.home : LucideIcons.arrowRight),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
