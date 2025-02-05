import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizCard extends StatefulWidget {
  const QuizCard({Key? key}) : super(key: key);

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  int currentQuestionIndex = 0;
  bool isAnswered = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the volume of this shape?',
      'image': CustomPaint(
        painter: ShapePainter(),
      ),
      'choices': ['4.3 liter', '6.6 liter', '7.6 liter', '8.2 liter'],
      'correctAnswer': 1,
      'type': 'text'
    },
    {
      'question': 'Which image shows a cube?',
      'choices': [
        'https://example.com/cylinder.png',
        'https://example.com/sphere.png',
        'https://example.com/cube.png',
        'https://example.com/pyramid.png'
      ],
      'correctAnswer': 2,
      'type': 'image'
    },
    // Add more questions here...
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void checkAnswer(int selectedIndex) {
    if (isAnswered) return;

    setState(() {
      isAnswered = true;
    });

    if (selectedIndex == questions[currentQuestionIndex]['correctAnswer']) {
      // Correct answer
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Text('Well done!'),
            actions: [
              TextButton(
                child: Text('Next'),
                onPressed: () {
                  Navigator.of(context).pop();
                  nextQuestion();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Wrong answer
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incorrect'),
            content: Text(
                'The correct answer was: ${questions[currentQuestionIndex]['choices'][questions[currentQuestionIndex]['correctAnswer']]}'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Timer(Duration(seconds: 2), () {
                    nextQuestion();
                  });
                },
              ),
            ],
          );
        },
      );
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        isAnswered = false;
      });
    } else {
      // Quiz finished
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz Completed'),
            content: Text('You have completed all questions!'),
            actions: [
              TextButton(
                child: Text('Restart'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    currentQuestionIndex = 0;
                    isAnswered = false;
                  });
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Quiz ${currentQuestionIndex + 1}/${questions.length}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (currentQuestion['image'] != null)
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    child: currentQuestion['image'],
                  ),
                ),
              SizedBox(height: 24),
              Text(
                currentQuestion['question'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ...List.generate(
                currentQuestion['choices'].length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: ElevatedButton(
                    onPressed: () => checkAnswer(index),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFF6B4EFF),
                      backgroundColor: Color(0xFFF3F0FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${String.fromCharCode(65 + index)}.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: currentQuestion['type'] == 'image'
                              ? Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.network(
                                    currentQuestion['choices'][index],
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Icon(Icons.error),
                                  ),
                                )
                              : Text(
                                  currentQuestion['choices'][index],
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw the front rectangle
    canvas.drawRect(
      Rect.fromLTWH(40, size.height - 80, 80, 60),
      paint,
    );

    // Draw the top rectangle
    final topPath = Path()
      ..moveTo(40, size.height - 80)
      ..lineTo(120, size.height - 80)
      ..lineTo(160, size.height - 120)
      ..lineTo(80, size.height - 120)
      ..close();
    canvas.drawPath(topPath, paint);

    // Draw the side rectangle
    final sidePath = Path()
      ..moveTo(120, size.height - 80)
      ..lineTo(120, size.height - 20)
      ..lineTo(160, size.height - 60)
      ..lineTo(160, size.height - 120)
      ..close();
    canvas.drawPath(sidePath, paint);

    // Draw dimension lines and text
    final textStyle = TextStyle(
      color: Colors.black87,
      fontSize: 12,
    );
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // Add dimension texts
    void drawText(String text, double x, double y) {
      textPainter.text = TextSpan(text: text, style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas, Offset(x, y));
    }

    drawText('14 cm', 80, size.height - 15);
    drawText('18 cm', 165, size.height - 90);
    drawText('9 cm', 30, size.height - 50);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
