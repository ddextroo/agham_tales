import 'package:shared_preferences/shared_preferences.dart';

import '../model/book.dart';

class BookController {

  Future<List<Book>> getBooks() async {
    final prefs = await SharedPreferences.getInstance();

    List<Book> defaultBooks = [
      Book(
        imageUrl: "assets/images/cover_books/bennie.png",
        pdfPath: "assets/stories/bennie.pdf",
        title: "Bennie’s Forcestatic Adventure",
        totalPages: 10,
        totalQuizScore: 10,
      ),
      Book(
        imageUrl: "assets/images/cover_books/lily.png",
        pdfPath: "assets/stories/lily.pdf",
        title: "Lily and The Swing",
        totalPages: 8,
        totalQuizScore: 20,
      ),
      Book(
        imageUrl: "assets/images/cover_books/wonder.png",
        pdfPath: "assets/stories/wonders.pdf",
        title: "The Day of Moving Wonders",
        totalPages: 8,
        totalQuizScore: 20,
      ),
      Book(
        imageUrl: "assets/images/cover_books/mystical.png",
        pdfPath: "assets/stories/mystical.pdf",
        title: "Leo and The Mystical Cave",
        totalPages: 8,
        totalQuizScore: 20,
      ),
    ];
    for (int i = 0; i < defaultBooks.length; i++) {
      final keyPrefix = 'book_${defaultBooks[i].title.hashCode}';
      if (prefs.getString('$keyPrefix.title') == null) {
        await prefs.setString('$keyPrefix.imageUrl', defaultBooks[i].imageUrl);
        await prefs.setString('$keyPrefix.pdfPath', defaultBooks[i].pdfPath);
        await prefs.setString('$keyPrefix.title', defaultBooks[i].title);
        await prefs.setBool('$keyPrefix.isLocked', i == 0 ? false : true);
        await prefs.setInt('$keyPrefix.currentPage', 1);
        await prefs.setInt('$keyPrefix.totalPages', defaultBooks[i].totalPages);
        await prefs.setInt('$keyPrefix.quizScore', 0);
        await prefs.setInt('$keyPrefix.totalQuizScore', defaultBooks[i].totalQuizScore ?? 0);
      }
      final book = await loadBookState(keyPrefix);
      if (book.title.isNotEmpty) {
        defaultBooks[i] = book;
      }
    }

    return defaultBooks;
  }


  Future<Book> loadBookState(String keyPrefix) async {
    final prefs = await SharedPreferences.getInstance();

    return Book(
      imageUrl: prefs.getString('$keyPrefix.imageUrl') ?? '',
      pdfPath: prefs.getString('$keyPrefix.pdfPath') ?? '',
      title: prefs.getString('$keyPrefix.title') ?? '',
      isLocked: prefs.getBool('$keyPrefix.isLocked') ?? true,
      currentPage: prefs.getInt('$keyPrefix.currentPage') ?? 1,
      totalPages: prefs.getInt('$keyPrefix.totalPages') ?? 0,
      quizScore: prefs.getInt('$keyPrefix.quizScore'),
      totalQuizScore: prefs.getInt('$keyPrefix.totalQuizScore') ?? 0,
    );
  }



  Future<void> saveCurrentPage(String keyPrefix, int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$keyPrefix.currentPage', page);
  }

  Future<void> unlockNextBook(String keyPrefix) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$keyPrefix.nextBookUnlocked', true);
    print("Next book unlocked for $keyPrefix!");
  }
}
