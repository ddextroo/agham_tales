import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DictionaryDialog extends StatelessWidget {
  final String word;
  final String pronunciation;
  final String partOfSpeech;
  final String definition;

  const DictionaryDialog({
    super.key,
    required this.word,
    required this.pronunciation,
    required this.partOfSpeech,
    required this.definition,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize FlutterTTS instance
    FlutterTts flutterTts = FlutterTts();

    // Function to speak the pronunciation
    Future<void> _speak() async {
      await flutterTts.speak(word);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicWidth(
        // Makes the container adjust its width based on children
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            // Ensures the row width is determined by the children
            children: [
              Container(
                width: 12,
                decoration: BoxDecoration(
                  color: Color(0xFF0284c7),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              word.toUpperCase(),
                              style: GoogleFonts.roboto(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(LucideIcons.volume2, color: Color(0xFF0284c7)),
                            onPressed: _speak,
                            tooltip: 'Speak',
                            iconSize: 28,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Color(0xFF0284c7)),
                      const SizedBox(height: 8),
                      Text(
                        pronunciation,
                        style: GoogleFonts.notoSans(
                          fontSize: 18,
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        partOfSpeech,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 11),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Color(0xFF0284c7),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              definition,
                              style: const TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
