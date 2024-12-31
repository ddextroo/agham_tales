import 'package:agham_tales/model/dictionary.dart';
import 'package:agham_tales/model/quiz.dart';
import 'package:agham_tales/model/story_audio.dart';

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
  final List<Quiz> quizzes;
  final StoryAudio audios;

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
    required this.quizzes,
    required this.audios,
  });
}