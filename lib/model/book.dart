class Book {
  final String imageUrl;
  final String title;
  final double progress;
  final bool isLocked;
  final int currentPage;
  final int totalPages;
  final int? quizScore;
  final int? totalQuizScore;

  Book(this.imageUrl, this.progress, this.isLocked, this.currentPage, this.totalPages, this.quizScore, this.totalQuizScore, {required this.title});
}