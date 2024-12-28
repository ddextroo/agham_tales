import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(LucideIcons.info),
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
