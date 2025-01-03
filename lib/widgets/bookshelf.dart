import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/quiz.dart';
import '../model/story_audio.dart';

class BookCover extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double progress;
  final bool? isLocked;
  final int? currentPage;
  final int totalPages;
  final String pdfPath;
  final int? quizScore;
  final int totalQuizScore;
  final List<Quiz> quizzes;
  final StoryAudio audios;

  const BookCover({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.progress,
    this.isLocked,
    this.currentPage,
    required this.totalPages,
    required this.pdfPath,
    this.quizScore,
    required this.totalQuizScore,
    required this.quizzes,
    required this.audios,
  });

  @override
  State<BookCover> createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover> {
  late bool _isLocked;

  @override
  void initState() {
    super.initState();
    _isLocked = widget.isLocked ?? false;
  }

  // void _toggleLock() async {
  //   setState(() {
  //     _isLocked = !_isLocked;
  //   });
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   final keyPrefix = 'book_${widget.title.hashCode}';
  //   prefs.setBool('$keyPrefix.isLocked', _isLocked);
  // }

  void _navigateToNewPage() {
    if (!_isLocked) {
      Navigator.popAndPushNamed(context, "/story",
          arguments: {"book": widget.pdfPath, "title": widget.title});
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _navigateToNewPage,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      widget.imageUrl,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                    ),
                    if (_isLocked)
                      Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    Center(
                      child: IconButton(
                        icon: Icon(
                          _isLocked ? LucideIcons.lock : null,
                          color: Colors.white,
                          size: 32,
                        ), onPressed: () {  },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: widget.progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.progress == 1.0 ? Colors.green : Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Page ${widget.currentPage} of ${widget.totalPages}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (widget.quizScore != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'Quiz Score: ${widget.quizScore}/${widget.totalQuizScore}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
