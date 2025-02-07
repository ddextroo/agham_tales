import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../model/quiz.dart';
import '../controller/story_controller.dart';
import '../widgets/cloud_animation.dart';
import '../widgets/ribbon.dart';

class QuizCard extends StatefulWidget {
  final String book;
  final String title;

  const QuizCard({Key? key, required this.book, required this.title}) : super(key: key);

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
  late AudioPlayer _quizPlayer;

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
    saveQuizScore(score);
    Navigator.popAndPushNamed(context, "/home");
  }

  Future<void> saveQuizScore(int score) async {
    await BookController().saveQuizScore(_keyPrefix, score);
    final String? nextBook = await BookController().getNextBookKeyPrefix(_keyPrefix);
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
          color: Color(0xFF87CEEB), // Sky blue background
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Cloud animations
              CloudsOverlay(cloudCount: 20),

              Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: -1,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD2B48C), // Tan color for the card
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            padding: const EdgeInsets.all(7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Ribbon(
                                  color: Colors.red,
                                  width: 200,
                                  height: 40,
                                  child: Text(
                                    'Question ${currentQuestionIndex + 1} to ${quizzes.length}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    currentQuiz.question,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8B4513),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                if (showFeedback) ...[
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      isCorrect ? currentQuiz.correctFeedback : currentQuiz.incorrectFeedback,
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: isCorrect ? Colors.green : Colors.red,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 3.5, // Increased to make buttons even shorter
                          shrinkWrap: true,
                          children: currentQuiz.choices.entries.map((entry) {
                            final choiceKey = entry.key;
                            final choiceText = entry.value;
                            return ElevatedButton(
                              child: Text(
                                '$choiceKey. $choiceText',
                                style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold), // Further reduced font size
                                textAlign: TextAlign.center,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedAnswer == choiceKey
                                    ? (isCorrect ? Colors.green : Colors.red)
                                    : const Color(0xFFF1C40F), // Yellow color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30), // Further reduced border radius
                                  side: const BorderSide(color: Colors.white, width: 1), // Thinner white outline
                                ),
                              ),
                              onPressed: selectedAnswer == null ? () => handleAnswer(choiceKey) : null,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: showFeedback
          ? ElevatedButton(
        onPressed: isLastQuestion ? handleTryAgain : handleNext,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isLastQuestion ? 'Go back to home' : 'Next',
              style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            Icon(
              isLastQuestion ? LucideIcons.home : LucideIcons.arrowRight,
              size: 14,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF1C40F), // Yellow color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Colors.white, width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

