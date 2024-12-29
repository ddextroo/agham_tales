import 'package:agham_tales/model/dictionary.dart';

class Book {
  final String imageUrl;
  final String pdfPath;
  final String title;
  bool? isLocked;
  int? currentPage;
  final int totalPages;
  int? quizScore;
  final int totalQuizScore;
  final Map<String, Dictionary> glossary;

  Book({
    required this.imageUrl,
    required this.pdfPath,
    required this.title,
    this.isLocked,
    this.currentPage,
    required this.totalPages,
    this.quizScore,
    required this.totalQuizScore,
    required this.glossary,
  });
}