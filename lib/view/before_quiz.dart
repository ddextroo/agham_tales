import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BeforeQuizScreen extends StatefulWidget {
  final String book;
  final String title;

  const BeforeQuizScreen({super.key, required this.book, required this.title});

  @override
  State<BeforeQuizScreen> createState() => _BeforeQuizScreenState();
}

class _BeforeQuizScreenState extends State<BeforeQuizScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade200,
              Colors.green.shade200,
              Colors.yellow.shade100,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  "Welcome to",
                  style: TextStyle(
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
                const SizedBox(height: 12),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: screenHeight * 0.025,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.blue.shade200,
                        offset: const Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.2,
                        height: screenWidth * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.blue.shade100,
                              Colors.blue.shade50,
                            ],
                          ),
                        ),
                      ).animate().scale(
                          duration: 1000.ms, curve: Curves.elasticOut),
                      Lottie.network(
                        'https://assets5.lottiefiles.com/packages/lf20_xyadoh9h.json',
                        width: screenWidth * 0.15,
                        height: screenWidth * 0.15,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to the quiz screen
                    Navigator.popAndPushNamed(context, "/quiz",
                        arguments: {"book": widget.book, "title": widget.title});
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade600,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Start Quiz',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.play_arrow_rounded,
                        size: 24,
                        color: Colors.yellow.shade300,
                      )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(duration: 1000.ms, color: Colors.white)
                          .shake(hz: 4, curve: Curves.easeInOutCubic)
                          .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.1, 1.1),
                        duration: 600.ms,
                      ),
                    ],
                  ),
                )
                    .animate()
                    .slideY(
                    begin: 1, duration: 600.ms, curve: Curves.easeOutQuad)
                    .fadeIn(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
