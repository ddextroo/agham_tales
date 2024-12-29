import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstTime();
  }

  Future<void> _firstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    bool? isFirstTime = prefs.getBool("first_time") ?? true;

    if (!isFirstTime) {
      Navigator.popAndPushNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        // Screen 1
        PageViewModel(
          title: "Welcome to Agham Tales!",
          body:
              "Explore interactive e-storybooks designed to make science fun, engaging, and easy to learn.",
          image: _buildImage('assets/images/geniuses.png'),
          decoration: getPageDecoration(),
        ),
        // Screen 2
        PageViewModel(
          title: "Interactive Adventures Await",
          body:
              "Dive into stories with dynamic sound effects, lively dialogues, and hands-on interaction.",
          image: _buildImage('assets/images/exploring.png'),
          decoration: getPageDecoration(),
        ),
        // Screen 3
        PageViewModel(
          title: "Challenge Your Knowledge",
          body:
              "Test your understanding with exciting quizzes at the end of every story and level up your learning!",
          image: _buildImage('assets/images/winners.png'),
          decoration: getPageDecoration(),
        ),
      ],
      onDone: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("first_time", false);
        Navigator.popAndPushNamed(context, "/home");
      },
      onSkip: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("first_time", false);
        Navigator.popAndPushNamed(context, "/home");
      },
      showSkipButton: true,
      skip: Text("Skip",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF212121))),
      next: Icon(LucideIcons.arrowRight, color: Colors.blue),
      done: Text("Get Started",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF212121))),
      dotsDecorator: getDotsDecorator(),
    );
  }

  Widget _buildImage(String path) {
    return Center(
      child: Image.asset(path, width: 300),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 16),
      imagePadding: EdgeInsets.all(24),
    );
  }

  DotsDecorator getDotsDecorator() {
    return DotsDecorator(
      size: Size(10.0, 10.0),
      color: Colors.grey,
      activeSize: Size(22.0, 10.0),
      activeShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      activeColor: Colors.blue,
    );
  }
}
