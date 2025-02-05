import 'package:agham_tales/view/before_quiz.dart';
import 'package:agham_tales/view/home.dart';
import 'package:agham_tales/view/onboarding.dart';
import 'package:agham_tales/view/quiz_card.dart';
import 'package:agham_tales/view/splash.dart';
import 'package:agham_tales/view/story.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      debugShowCheckedModeBanner: false,
      theme: ShadThemeData(
        colorScheme: const ShadGreenColorScheme.light(
          background: Color(0xFFFEFEFE),
        ),
        brightness: Brightness.light,
        primaryButtonTheme: const ShadButtonTheme(
          backgroundColor: Color(0xFF0284c7),
        ),
        outlineButtonTheme:
        const ShadButtonTheme(foregroundColor: Color(0xFF171717)),
        textTheme: ShadTextTheme.fromGoogleFont(
          GoogleFonts.poppins,
          // colorScheme: const ShadGreenColorScheme.light(),
        ),
      ),
      home: const Splashscreen(),
      routes: {
        '/splash': (context) => const Splashscreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
        '/quiz': (context) => const QuizCard(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/story') {
          final args = settings.arguments as Map<String, dynamic>?;
          final bookPath = args?['book'] ?? '';
          final title = args?['title'] ?? '';
          return MaterialPageRoute(
            builder: (context) => StoryBook(book: bookPath, title: title,),
          );
        }
        if (settings.name == '/before_quiz') {
          final args = settings.arguments as Map<String, dynamic>?;
          final bookPath = args?['book'] ?? '';
          final title = args?['title'] ?? '';
          return MaterialPageRoute(
            builder: (context) => BeforeQuizScreen(book: bookPath, title: title,),
          );
        }
        // if (settings.name == '/quiz') {
        //   final args = settings.arguments as Map<String, dynamic>?;
        //   final bookPath = args?['book'] ?? '';
        //   final title = args?['title'] ?? '';
        //   return MaterialPageRoute(
        //     builder: (context) => QuizCard(book: bookPath, title: title,),
        //   );
        // }
        return null; // If no route matches, return null
      },
    );
  }
}

