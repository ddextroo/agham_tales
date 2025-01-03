import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/story_controller.dart';
import '../model/book.dart';
import '../widgets/bookshelf.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<Book>> _booksFuture;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _booksFuture = _initializeBooks();
  }

  Future<List<Book>> _initializeBooks() async {
    return BookController().getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0284c7),
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showShadDialog(
                context: context,
                builder: (context) => ShadDialog(
                  radius: BorderRadius.circular(10.0),
                  expandActionsWhenTiny: true,
                  removeBorderRadiusWhenTiny: false,
                  title: const Text(
                    'About Us',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  description: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Our App',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            """
              This application is likened to a book reader app. However, it focuses more on originally crafted e-storybooks for science learning. In contrast to existing book reader apps such as Moon Reader, the books in the application are interactive with dialogue, sound effects, and exciting quizzes at the end of every story.

              To make learning fun and challenging, the succeeding books can only be accessed once you finish the previous book. It can also be utilized offline.
              """,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Our Team',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: teamMembers.map((member) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '• ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          member,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ShadButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
            icon:  Icon(Icons.info),
            iconSize: 20,
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Book>>(
          future: _booksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(child: Text('Failed to load books'));
            }

            final books = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Books",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.60,
                    children: books.map((book) {
                      // Calculate progress based on currentPage
                      double progress =
                          (book.currentPage ?? 0) / book.totalPages;

                      return BookCover(
                        imageUrl: book.imageUrl,
                        title: book.title,
                        progress: progress,
                        totalPages: book.totalPages,
                        isLocked: book.isLocked,
                        currentPage: (book.currentPage ?? 0),
                        pdfPath: book.pdfPath,
                        totalQuizScore: book.totalQuizScore,
                        quizzes: book.quizzes,
                        quizScore: book.quizScore,
                        audios: book.audios,
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
// Team member list
const List<String> teamMembers = [
  'Amistoso, Fritzie A.',
  'Baguio, Marie Gretna R.',
  'Macasero, Louie Marie P.',
  'Monterola, Jelaena Y.',
  'Remo, James Keynneth',
  'Vargas, Van Keith Ludwig',
];
