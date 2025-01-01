import 'package:agham_tales/utils/url_prefix_remove.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/story_controller.dart';
import '../widgets/dictionary_dialog.dart';

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
  String? nextBook = "";

  late AudioPlayer _ambientPlayer;
  late AudioPlayer _storyPlayer;
  bool _isAmbientPlaying = true;
  bool _isStoryPlaying = false;

  Future<void> _initAudioPlayers() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    final book = await BookController().loadBookState(_keyPrefix);
    await AudioPlayer.clearAssetCache();

    _ambientPlayer = AudioPlayer();
    _storyPlayer = AudioPlayer();

    // Load and loop ambient audio
    await _ambientPlayer.setAsset(book.audios.ambient ?? "");
    await _ambientPlayer.play();
    await _ambientPlayer.setLoopMode(LoopMode.one);
    await _ambientPlayer.setVolume(1.0);
    await _storyPlayer.setVolume(1.0);

    if (book.audios.audioPerPage.isNotEmpty) {
      await _storyPlayer.setAsset(book.audios.audioPerPage[0]);
    }
  }

  void goToPage(int page) {
    if (_controller.isReady) {
      _controller.setCurrentPageNumber(page);
      _controller.goToPage(pageNumber: page);
      setState(() {
        _currentPage = page;
      });
      _saveCurrentPage(page);
      _changeStoryAudio(page);

      if (_currentPage == _controller.pageCount) {
        Navigator.popAndPushNamed(context, "/before_quiz",
            arguments: {"book": widget.book, "title": widget.title});
      }
    } else {
      print("PDF is not ready yet.");
    }
  }

  Future<void> _changeStoryAudio(int page) async {
    final book = await BookController().loadBookState(_keyPrefix);
    if (book.audios.audioPerPage.length >= page) {
      await _storyPlayer.stop();
      await _storyPlayer.setAsset(book.audios.audioPerPage[page - 1]);
      if (_isStoryPlaying) {
        await _storyPlayer.play();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _keyPrefix = 'book_${widget.title.hashCode}';
    _loadBookState();
    _initAudioPlayers();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _loadBookState() async {
    final book = await BookController().loadBookState(_keyPrefix);
    setState(() {
      _totalPages = book.totalPages;
    });
    nextBook = await BookController().getNextBookKeyPrefix(_keyPrefix);
  }

  Future<void> _saveCurrentPage(int page) async {
    await BookController().saveCurrentPage(_keyPrefix, page);
  }

  Future<void> _unlockNextBook() async {
    await BookController().unlockNextBook(nextBook!);
  }

  void showDictionaryDialog(BuildContext context, String word) async {
    final prefs = await SharedPreferences.getInstance();
    final book = await BookController().loadBookState(_keyPrefix);
    word = cleanUrl(word);

    // Retrieve the glossary for the book
    final glossary = book.glossary;
    // print(book.pdfPath);

    // Search for the word in the glossary
    if (glossary.containsKey(word)) {
      final dictionary = glossary[word]!;

      // Show the dialog with the word's details
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: DictionaryDialog(
            word: dictionary.word,
            pronunciation: dictionary.pronunciation,
            partOfSpeech: dictionary.partOfSpeech,
            definition: dictionary.definition,
          ),
        ),
      );
    } else {
      // Optionally handle the case where the word isn't found in the glossary
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: DictionaryDialog(
            word: word,
            pronunciation: "Not found",
            partOfSpeech: "N/A",
            definition: "No definition available.",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfViewer.asset(
        widget.book,
        controller: _controller,
        params: PdfViewerParams(
          linkHandlerParams: PdfLinkHandlerParams(
            linkColor: const Color(0x00000000),
            onLinkTap: (link) {
              showDictionaryDialog(context, link.url.toString());
              // showShadSheet(
              //     side: ShadSheetSide.bottom,
              //     context: context,
              //     builder: (context) => TranslationSheet(
              //         word: link.url.toString(),
              //         nextModule: arguments['nextModule'],
              //         currentIndex: currentIndex));
              // if (link.url != null) {
              //   navigateToUrl(link.url!);
              // } else if (link.dest != null) {
              //   controller.goToDest(link.dest);
              // }
            },
          ),
          enableKeyboardNavigation: false,
          scaleEnabled: false,
          panEnabled: false,
          margin: 0,
          backgroundColor: Colors.white,
          pageDropShadow: const BoxShadow(
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
              if (_currentPage <= _controller.pageCount) {
                goToPage(_currentPage + 1);
              }
            },
            child: const Icon(LucideIcons.arrowRight),
          ),
          const SizedBox(width: 16),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'ambient',
            onPressed: () {
              setState(() {
                _isAmbientPlaying = !_isAmbientPlaying;
                _isAmbientPlaying
                    ? _ambientPlayer.play()
                    : _ambientPlayer.pause();
              });
            },
            child: Icon(
                _isAmbientPlaying ? LucideIcons.volume2 : LucideIcons.volumeX),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'story',
            onPressed: () {
              setState(() {
                _isStoryPlaying = !_isStoryPlaying;
                _isStoryPlaying ? _storyPlayer.play() : _storyPlayer.pause();
              });
            },
            child: Icon(_isStoryPlaying
                ? LucideIcons.pauseCircle
                : LucideIcons.playCircle),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'repeat',
            onPressed: () => goToPage(1),
            child: const Icon(LucideIcons.repeat),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'savedPage',
            onPressed: () async {
              final book = await BookController().loadBookState(_keyPrefix);
              setState(() {
                _currentPage = book.currentPage!;
              });

              goToPage(_currentPage);
            },
            child: const Icon(LucideIcons.bookmark),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _saveCurrentPage(_currentPage);
    _ambientPlayer.dispose();
    _storyPlayer.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
