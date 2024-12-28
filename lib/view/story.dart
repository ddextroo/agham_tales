import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/story_controller.dart';

class StoryBook extends StatefulWidget {
  final String book;
  final String title;

  const StoryBook({super.key, required this.book, required this.title});

  @override
  State<StoryBook> createState() => _StoryBookState();
}

class _StoryBookState extends State<StoryBook> {
  final PdfViewerController _controller = PdfViewerController();
  int _currentPage = 1; // Default to the first page
  int _totalPages = 0; // Total pages in the book

  // Define the key prefix based on the book title's hashCode
  late String _keyPrefix;

  @override
  void initState() {
    super.initState();
    _keyPrefix = 'book_${widget.title.hashCode}';
    _loadBookState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _loadBookState() async {
    final book = await BookController().loadBookState(_keyPrefix);
    setState(() {
      _currentPage = book.currentPage!;
      _totalPages = book.totalPages;
    });

    if (_controller.isReady) {
      _controller.goToPage(pageNumber: _currentPage);
    }
  }

  Future<void> _saveCurrentPage(int page) async {
    await BookController().saveCurrentPage(_keyPrefix, page);
  }

  Future<void> _unlockNextBook() async {
    await BookController().unlockNextBook(_keyPrefix);
  }

  void goToPage(int page) {
    if (_controller.isReady) {
      _controller.setCurrentPageNumber(page);
      _controller.goToPage(pageNumber: page);
      setState(() {
        _currentPage = page;
      });
      _saveCurrentPage(page);

      if (_currentPage == _controller.pageCount) {
        _unlockNextBook();
      }
    } else {
      print("PDF is not ready yet.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfViewer.asset(
        widget.book,
        controller: _controller,
        params: const PdfViewerParams(
          enableKeyboardNavigation: false,
          scaleEnabled: false,
          panEnabled: false,
          margin: 0,
          backgroundColor: Colors.white,
          pageDropShadow: BoxShadow(
            color: Colors.transparent,
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: 'home',
            onPressed: () {
              Navigator.popAndPushNamed(context, "/home");
            },
            child: const Icon(LucideIcons.home),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'previous',
            onPressed: () {
              if (_currentPage > 1) {
                goToPage(_currentPage - 1);
              }
            },
            child: const Icon(LucideIcons.arrowLeft),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'next',
            onPressed: () {
              if (_currentPage < _controller.pageCount) {
                goToPage(_currentPage + 1);
              }
            },
            child: const Icon(LucideIcons.arrowRight),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'audio',
            onPressed: () => goToPage(_currentPage + 1),
            child: const Icon(LucideIcons.music),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'repeat',
            onPressed: () => goToPage(1),
            child: const Icon(LucideIcons.repeat),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _saveCurrentPage(_currentPage);
    super.dispose();
  }
}
