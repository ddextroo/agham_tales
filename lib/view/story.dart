import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StoryBook extends StatefulWidget {
  const StoryBook({super.key});

  @override
  State<StoryBook> createState() => _StoryBookState();
}

class _StoryBookState extends State<StoryBook> {
  final PdfViewerController _controller = PdfViewerController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller.isReady ? _controller : null;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void goToPage(int page) {
    if (_controller.isReady) {
      _controller.setCurrentPageNumber(page);
      _controller.goToPage(pageNumber: page);
      print(_controller.pageNumber);
    } else {
      print("PDF is not ready yet.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfViewer.asset(
        'assets/stories/book1.pdf',
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
            onPressed: () => _controller.pageNumber! <= 1 ? null : goToPage(_controller.pageNumber! - 1),
            child: const Icon(LucideIcons.arrowLeft),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'next',
              onPressed: () => _controller.pageNumber! >= _controller.pageCount ? null : goToPage(_controller.pageNumber! + 1),
            child: const Icon(LucideIcons.arrowRight),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'audio',
            onPressed: () => goToPage(_controller.pageNumber! + 1)
                ,
            child: const Icon(LucideIcons.music),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'repeat',
            onPressed: () => goToPage(1)
                ,
            child: const Icon(LucideIcons.repeat),
          ),
        ],
      ),
    );
  }
}
