import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BookCover extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double progress;
  final bool isLocked;
  final int currentPage;
  final int totalPages;
  final int? quizScore;
  final int? totalQuizScore;

  const BookCover({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.progress,
    required this.isLocked,
    required this.currentPage,
    required this.totalPages,
    this.quizScore,
    this.totalQuizScore,
  });

  @override
  State<BookCover> createState() => _BookCoverState();
}

class _BookCoverState extends State<BookCover> {
  late bool _isLocked;

  @override
  void initState() {
    super.initState();
    _isLocked = widget.isLocked;
  }

  void _toggleLock() {
    setState(() {
      _isLocked = !_isLocked;
    });
  }

  void _navigateToNewPage() {
    if (!_isLocked) {
      Navigator.popAndPushNamed(context, "/story");
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
                          _isLocked ? LucideIcons.lock : LucideIcons.unlock,
                          color: Colors.white,
                          size: 32,
                        ),
                        onPressed: _toggleLock,
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
                    if (widget.quizScore != null && widget.totalQuizScore != null)
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