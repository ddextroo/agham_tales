import 'package:agham_tales/view/home.dart';
import 'package:agham_tales/view/onboarding.dart';
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
        '/story': (context) => const StoryBook(),
      },
    );
  }
}

