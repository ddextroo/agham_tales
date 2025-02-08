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

  const QuizCard({Key? key, required this.book, required this.title})
      : super(key: key);

  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool showFeedback = false;
  int score = 0;
  List<Quiz>? quizzes;
  late String _keyPrefix;
  late AudioPlayer _correctSoundPlayer;
  late AudioPlayer _wrongSoundPlayer;
  late AudioPlayer _quizCompletePlayer;

  @override
  void initState() {
    _keyPrefix = 'book_${widget.title.hashCode}';
    super.initState();

    _correctSoundPlayer = AudioPlayer();
    _wrongSoundPlayer = AudioPlayer();
    _quizCompletePlayer = AudioPlayer();

    _correctSoundPlayer.setAsset('assets/audios/quiz_audio/success.mp3');
    _wrongSoundPlayer.setAsset('assets/audios/quiz_audio/fail.mp3');
    _quizCompletePlayer.setAsset('assets/audios/quiz_audio/after.mp3').then((_) {
      _quizCompletePlayer.setLoopMode(LoopMode.one);
    });

    _initQuiz();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _initQuiz() async {
    final book = await BookController().loadBookState(_keyPrefix);
    setState(() => quizzes = book.quizzes);
  }

  void handleAnswer(String answer) {
    final isCorrect = answer == quizzes![currentQuestionIndex].correctAnswer;
    final isLastQuestion = currentQuestionIndex == quizzes!.length - 1;

    setState(() {
      selectedAnswer = answer;
      showFeedback = true;
      if (isCorrect) score++;
    });

    (isCorrect ? _correctSoundPlayer : _wrongSoundPlayer)
      ..seek(Duration.zero)
      ..play();

    if (isLastQuestion) {
      _quizCompletePlayer.seek(Duration.zero);
      _quizCompletePlayer.play();
    }
  }

  Future<void> handleNext() async {
    await _correctSoundPlayer.stop();
    await _wrongSoundPlayer.stop();
    await _quizCompletePlayer.stop();

    setState(() {
      currentQuestionIndex++;
      selectedAnswer = null;
      showFeedback = false;
    });
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete! 🎉'),
        content: Text('Your Score: $score/${quizzes!.length}'),
        actions: [
          TextButton(
            child: const Text('Try Again'),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestionIndex = 0;
                score = 0;
                selectedAnswer = null;
                showFeedback = false;
              });
              _quizCompletePlayer.stop();
            },
          ),
          TextButton(
            child: const Text('Go Home'),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.popAndPushNamed(context, "/home");
            },
          ),
        ],
      ),
    );
  }

  Future<void> saveQuizScore(int score) async {
    await BookController().saveQuizScore(_keyPrefix, score);
    final nextBook = await BookController().getNextBookKeyPrefix(_keyPrefix);
    if (nextBook != null) await BookController().unlockNextBook(nextBook);
  }

  @override
  void dispose() {
    _correctSoundPlayer.dispose();
    _wrongSoundPlayer.dispose();
    _quizCompletePlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (quizzes == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final currentQuiz = quizzes![currentQuestionIndex];
    final isLastQuestion = currentQuestionIndex == quizzes!.length - 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFF87CEEB)),
        child: SafeArea(
          child: Stack(
            children: [
              const CloudsOverlay(cloudCount: 50),
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
                              color: const Color(0xFFD2B48C),
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
                                    'Question ${currentQuestionIndex + 1} of ${quizzes!.length}',
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
                                      selectedAnswer == currentQuiz.correctAnswer
                                          ? currentQuiz.correctFeedback
                                          : currentQuiz.incorrectFeedback,
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: selectedAnswer == currentQuiz.correctAnswer
                                            ? Colors.green
                                            : Colors.red,
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
                          childAspectRatio: 3.5, // Adjusted aspect ratio
                          shrinkWrap: true,
                          children: currentQuiz.choices.entries.map((entry) {
                            final choiceKey = entry.key;
                            final isCorrect = choiceKey == currentQuiz.correctAnswer;
                            final isSelected = choiceKey == selectedAnswer;

                            return ElevatedButton(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (showFeedback) ...[
                                      Icon(
                                        isCorrect ? Icons.check : (isSelected ? Icons.close : null),
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                    ],
                                    Flexible( // Added Flexible widget
                                      child: Text(
                                        '$choiceKey. ${entry.value}',
                                        softWrap: true, // Enabled text wrapping
                                        maxLines: 2, // Limit to 2 lines
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12, // Slightly increased font size
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: showFeedback
                                    ? (isCorrect
                                    ? Colors.green
                                    : isSelected
                                    ? Colors.red
                                    : const Color(0xFFF1C40F))
                                    : const Color(0xFFF1C40F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: showFeedback
                                        ? (isCorrect
                                        ? Colors.green.shade800
                                        : isSelected
                                        ? Colors.red.shade800
                                        : Colors.white)
                                        : Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onPressed: selectedAnswer == null
                                  ? () => handleAnswer(choiceKey)
                                  : null,
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
        onPressed: () async {
          if (isLastQuestion) {
            await saveQuizScore(score);
            _showScoreDialog();
          } else {
            await handleNext();
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isLastQuestion ? 'Finish Quiz' : 'Next',
              style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            Icon(
              isLastQuestion ? LucideIcons.trophy : LucideIcons.arrowRight,
              size: 14,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF1C40F),
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