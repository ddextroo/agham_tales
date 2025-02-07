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

class _StoryBookState extends State<StoryBook>
    with SingleTickerProviderStateMixin {
  final PdfViewerController _controller = PdfViewerController();
  int _currentPage = 1; // Default to the first page
  int _totalPages = 0; // Total pages in the book

  // Define the key prefix based on the book title's hashCode
  late String _keyPrefix;
  String? nextBook = "";

  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isControlsVisible = true;

  late AudioPlayer _ambientPlayer;
  late AudioPlayer _storyPlayer;
  bool _isAmbientPlaying = true;
  bool _isStoryPlaying = false;

  Future<void> _initAudioPlayers() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    final book = await BookController().loadBookState(_keyPrefix);
    // await AudioPlayer.clearAssetCache();

    _ambientPlayer = AudioPlayer();
    _storyPlayer = AudioPlayer();


    // Load and loop ambient audio
    await _ambientPlayer.setAsset(book.audios.ambient ?? "");
    await _ambientPlayer.play();
    await _ambientPlayer.setLoopMode(LoopMode.all);


    if (book.audios.audioPerPage.isNotEmpty) {
      await _storyPlayer.setAsset(book.audios.audioPerPage[0]);
    }
  }

  void goToPage(int page) {
    if (_controller.isReady) {
      Offset zoomCenter = Offset(0.0, 0.0); // Top-left corner
      double zoomLevel = 0.8; // 80% zoom

      _controller.setZoom(zoomCenter, zoomLevel);
      _controller.setCurrentPageNumber(page);
      _controller.goToPage(pageNumber: page);
      setState(() {
        _currentPage = page;
      });
      _saveCurrentPage(page);
      _changeStoryAudio(page);

      if (_currentPage > _controller.pageCount) {
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

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Start with controls visible
    _animationController.value = 1.0;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _toggleControls() {
    setState(() {
      _isControlsVisible = !_isControlsVisible;
      if (_isControlsVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
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
      body: Stack(
        children: [
          PdfViewer.asset(
            widget.book,
            controller: _controller,
            params: PdfViewerParams(
              linkHandlerParams: PdfLinkHandlerParams(
                linkColor: const Color(0x00000000),
                onLinkTap: (link) =>
                    showDictionaryDialog(context, link.url.toString()),
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
          Positioned(
            right: 16,
            bottom: 100,
            child: FloatingActionButton(
              heroTag: 'toggle',
              mini: true,
              backgroundColor: Color(0xFF0284c7).withOpacity(0.6),
              foregroundColor: Colors.white,
              onPressed: _toggleControls,
              child: Icon(
                  _isControlsVisible ? LucideIcons.eyeOff : LucideIcons.eye),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(_animation),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Color(0xFF0284c7).withOpacity(0.6),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFAB(
                  heroTag: 'home',
                  icon: LucideIcons.home,
                  onPressed: () => Navigator.popAndPushNamed(context, "/home"),
                  tooltip: 'Home',
                ),
                _buildDivider(),
                _buildFAB(
                  heroTag: 'previous',
                  icon: LucideIcons.arrowLeft,
                  onPressed: () {
                    if (_currentPage > 1) goToPage(_currentPage - 1);
                  },
                  tooltip: 'Previous Page',
                ),
                _buildFAB(
                  heroTag: 'next',
                  icon: LucideIcons.arrowRight,
                  onPressed: () {
                    if (_currentPage <= _controller.pageCount)
                      goToPage(_currentPage + 1);
                  },
                  tooltip: 'Next Page',
                ),
                _buildDivider(),
                _buildFAB(
                  heroTag: 'ambient',
                  icon: _isAmbientPlaying
                      ? LucideIcons.volume2
                      : LucideIcons.volumeX,
                  onPressed: () {
                    setState(() {
                      _isAmbientPlaying = !_isAmbientPlaying;
                      _isAmbientPlaying
                          ? _ambientPlayer.play()
                          : _ambientPlayer.pause();
                    });
                  },
                  tooltip: 'Toggle Ambient Sound',
                ),
                _buildFAB(
                  heroTag: 'story',
                  icon: _isStoryPlaying
                      ? LucideIcons.pauseCircle
                      : LucideIcons.playCircle,
                  onPressed: ()  async {
                    await _ambientPlayer.setVolume(1);
                    await _storyPlayer.setVolume(1);

                    setState(() {
                      _isStoryPlaying = !_isStoryPlaying;
                      _isStoryPlaying
                          ? _storyPlayer.play()
                          : _storyPlayer.pause();
                    });
                  },
                  tooltip: 'Toggle Story Narration',
                ),
                _buildDivider(),
                _buildFAB(
                  heroTag: 'repeat',
                  icon: LucideIcons.repeat,
                  onPressed: () => goToPage(1),
                  tooltip: 'Restart Story',
                ),
                _buildFAB(
                  heroTag: 'savedPage',
                  icon: LucideIcons.bookmark,
                  onPressed: () async {
                    final book =
                        await BookController().loadBookState(_keyPrefix);
                    setState(() => _currentPage = book.currentPage!);
                    goToPage(_currentPage);
                  },
                  tooltip: 'Go to Saved Page',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAB({
    required String heroTag,
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Tooltip(
        message: tooltip,
        child: FloatingActionButton(
          heroTag: heroTag,
          onPressed: onPressed,
          mini: true,
          backgroundColor: Colors.white.withOpacity(0.9),
          foregroundColor: Colors.black87,
          elevation: 0,
          hoverElevation: 2,
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 24,
        width: 1,
        color: Colors.white.withOpacity(0.3),
      ),
    );
  }

  @override
  void dispose() {
    _saveCurrentPage(_currentPage);
    _ambientPlayer.dispose();
    _storyPlayer.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitDown,
    //   DeviceOrientation.portraitUp,
    // ]);
    super.dispose();
  }
}
