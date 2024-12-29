import 'package:shared_preferences/shared_preferences.dart';

import '../model/book.dart';
import '../model/dictionary.dart';

class BookController {
  Future<List<Book>> getBooks() async {
    final prefs = await SharedPreferences.getInstance();

    List<Book> defaultBooks = [
      Book(
        imageUrl: "assets/images/cover_books/bennie.png",
        pdfPath: "assets/stories/bennie.pdf",
        title: "Bennie’s Forcestatic Adventure",
        totalPages: 13,
        totalQuizScore: 10,
        glossary: {
          "exploring": Dictionary(
            word: "exploring",
            definition: "Looking around for new things.",
            pronunciation: "/ɛksˈplɔrɪŋ/",
            partOfSpeech: "Verb",
          ),
          "strength": Dictionary(
            word: "strength",
            definition: "How strong you are.",
            pronunciation: "/strɛŋθ/",
            partOfSpeech: "Noun",
          ),
          "muscles": Dictionary(
            word: "muscles",
            definition: "Parts of your body that help you move.",
            pronunciation: "/ˈmʌsəlz/",
            partOfSpeech: "Noun",
          ),
          "barely": Dictionary(
            word: "barely",
            definition: "Almost not.",
            pronunciation: "/ˈbɛərli/",
            partOfSpeech: "Adverb",
          ),
          "direction": Dictionary(
            word: "direction",
            definition: "The way something is going.",
            pronunciation: "/dɪˈrɛkʃən/",
            partOfSpeech: "Noun",
          ),
          "force": Dictionary(
            word: "force",
            definition: "A push or pull.",
            pronunciation: "/fɔrs/",
            partOfSpeech: "Noun",
          ),
          "motion": Dictionary(
            word: "motion",
            definition: "Moving.",
            pronunciation: "/ˈmoʊʃən/",
            partOfSpeech: "Noun",
          ),
          "experimenting": Dictionary(
            word: "experimenting",
            definition: "Trying new things.",
            pronunciation: "/ɛksˌpɛrɪˈmɛntɪŋ/",
            partOfSpeech: "Verb",
          ),
          "curious": Dictionary(
            word: "curious",
            definition: "Wanting to learn.",
            pronunciation: "/ˈkjʊriəs/",
            partOfSpeech: "Adjective",
          ),
          "discovering": Dictionary(
            word: "discovering",
            definition: "Finding out something new.",
            pronunciation: "/dɪsˈkʌvərɪŋ/",
            partOfSpeech: "Verb",
          ),
        },
      ),
      Book(
        imageUrl: "assets/images/cover_books/lily.png",
        pdfPath: "assets/stories/lily.pdf",
        title: "Lily and The Swing",
        totalPages: 7,
        totalQuizScore: 20,
        glossary: {
          "soar": Dictionary(
            word: "soar",
            definition: "Go up high.",
            pronunciation: "/sɔːr/",
            partOfSpeech: "Verb",
          ),
          "gently": Dictionary(
            word: "gently",
            definition: "Softly or calmly.",
            pronunciation: "/ˈdʒent.li/",
            partOfSpeech: "Adverb",
          ),
          "force": Dictionary(
            word: "force",
            definition: "A push or pull.",
            pronunciation: "/fɔːrs/",
            partOfSpeech: "Noun",
          ),
          "gravity": Dictionary(
            word: "gravity",
            definition: "What pulls things down.",
            pronunciation: "/ˈɡræv.ɪ.ti/",
            partOfSpeech: "Noun",
          ),
          "toward": Dictionary(
            word: "toward",
            definition: "Closer to something.",
            pronunciation: "/tɔːrd/ or /təˈwɔːrd/",
            partOfSpeech: "Preposition",
          ),
          "whether": Dictionary(
            word: "whether",
            definition: "Choosing between two things.",
            pronunciation: "/ˈweð.ər/",
            partOfSpeech: "Conjunction",
          ),
          "added": Dictionary(
            word: "added",
            definition: "Said more.",
            pronunciation: "/ˈæd.ɪd/",
            partOfSpeech: "Verb",
          ),
          "interesting": Dictionary(
            word: "interesting",
            definition:
                "Something that makes you curious or excited to know more about it.",
            pronunciation: "/ˈɪn.trə.stɪŋ/ or /ˈɪn.tə.res.tɪŋ/",
            partOfSpeech: "Adjective",
          ),
        },
      ),
      Book(
        imageUrl: "assets/images/cover_books/wonder.png",
        pdfPath: "assets/stories/wonders.pdf",
        title: "The Day of Moving Wonders",
        totalPages: 9,
        totalQuizScore: 20,
        glossary: {
          "swirled": Dictionary(
            word: "swirled",
            definition: "Moved in circles.",
            pronunciation: "/swɜːrld/",
            partOfSpeech: "Verb",
          ),
          "nudge": Dictionary(
            word: "nudge",
            definition: "A little push.",
            pronunciation: "/nʌdʒ/",
            partOfSpeech: "Noun or Verb",
          ),
          "motion": Dictionary(
            word: "motion",
            definition: "Moving.",
            pronunciation: "/ˈmoʊ.ʃən/",
            partOfSpeech: "Noun",
          ),
          "puzzled": Dictionary(
            word: "puzzled",
            definition: "Confused.",
            pronunciation: "/ˈpʌz.əld/",
            partOfSpeech: "Adjective",
          ),
          "spinning": Dictionary(
            word: "spinning",
            definition: "Turning in a circle.",
            pronunciation: "/ˈspɪn.ɪŋ/",
            partOfSpeech: "Verb",
          ),
          "rolling": Dictionary(
            word: "rolling",
            definition: "Moving while turning.",
            pronunciation: "/ˈroʊ.lɪŋ/",
            partOfSpeech: "Verb",
          ),
          "discover": Dictionary(
            word: "discover(ed)",
            definition: "Find something new.",
            pronunciation: "/dɪˈskʌv.ər/ or /dɪˈskʌv.ərd/",
            partOfSpeech: "Verb",
          ),
          "discovered": Dictionary(
            word: "discover(ed)",
            definition: "Find something new.",
            pronunciation: "/dɪˈskʌv.ər/ or /dɪˈskʌv.ərd/",
            partOfSpeech: "Verb",
          ),
        },
      ),
      Book(
        imageUrl: "assets/images/cover_books/mystical.png",
        pdfPath: "assets/stories/mystical.pdf",
        title: "Leo and The Mystical Cave",
        totalPages: 10,
        totalQuizScore: 20,
        glossary: {
          "chilly": Dictionary(
            word: "chilly",
            definition: "A little cold.",
            pronunciation: "/ˈtʃɪl.i/",
            partOfSpeech: "Adjective",
          ),
          "absorb": Dictionary(
            word: "absorb",
            definition: "Take in.",
            pronunciation: "/əbˈzɔːrb/ or /əbˈsɔːrb/",
            partOfSpeech: "Verb",
          ),
          "energy": Dictionary(
            word: "energy",
            definition: "Power for movement, light, or heat.",
            pronunciation: "/ˈen.ər.dʒi/",
            partOfSpeech: "Noun",
          ),
          "accidentally": Dictionary(
            word: "accidentally",
            definition: "Not on purpose.",
            pronunciation: "/ˌæk.sɪˈden.təl.i/",
            partOfSpeech: "Adverb",
          ),
          "echoed": Dictionary(
            word: "echoed",
            definition: "A sound that comes back.",
            pronunciation: "/ˈek.oʊd/",
            partOfSpeech: "Verb",
          ),
          "bounce": Dictionary(
            word: "bounce",
            definition: "To hit and come back.",
            pronunciation: "/baʊns/",
            partOfSpeech: "Verb",
          ),
          "bounced": Dictionary(
            word: "bounce",
            definition: "To hit and come back.",
            pronunciation: "/baʊns/",
            partOfSpeech: "Verb",
          ),
          "flashlight": Dictionary(
            word: "flashlight",
            definition: "A carry light for the dark.",
            pronunciation: "/ˈflæʃ.laɪt/",
            partOfSpeech: "Noun",
          ),
          "thrilled": Dictionary(
            word: "thrilled",
            definition: "Very excited.",
            pronunciation: "/θrɪld/",
            partOfSpeech: "Adjective",
          ),
        },
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
        await prefs.setInt(
            '$keyPrefix.totalQuizScore', defaultBooks[i].totalQuizScore);

        List<String> glossaryData = defaultBooks[i]
            .glossary
            .values
            .map((dict) =>
                "${dict.word}|${dict.definition}|${dict.pronunciation}|${dict.partOfSpeech}")
            .toList();
        await prefs.setStringList('$keyPrefix.glossary', glossaryData);
      }

      // Load the book state including glossary
      final book = await loadBookState(keyPrefix);
      if (book.title.isNotEmpty) {
        defaultBooks[i] = book;
      }
    }

    return defaultBooks;
  }

  Future<Book> loadBookState(String keyPrefix) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> glossaryData =
        prefs.getStringList('$keyPrefix.glossary') ?? [];
    Map<String, Dictionary> glossary = {};
    for (String entry in glossaryData) {
      final parts = entry.split('|');
      if (parts.length == 4) {
        glossary[parts[0]] = Dictionary(
          word: parts[0],
          definition: parts[1],
          pronunciation: parts[2],
          partOfSpeech: parts[3],
        );
      }
    }

    return Book(
      imageUrl: prefs.getString('$keyPrefix.imageUrl') ?? '',
      pdfPath: prefs.getString('$keyPrefix.pdfPath') ?? '',
      title: prefs.getString('$keyPrefix.title') ?? '',
      isLocked: prefs.getBool('$keyPrefix.isLocked') ?? true,
      currentPage: prefs.getInt('$keyPrefix.currentPage') ?? 1,
      totalPages: prefs.getInt('$keyPrefix.totalPages') ?? 0,
      quizScore: prefs.getInt('$keyPrefix.quizScore'),
      totalQuizScore: prefs.getInt('$keyPrefix.totalQuizScore') ?? 0,
      glossary: glossary,
    );
  }

  Future<void> saveCurrentPage(String keyPrefix, int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$keyPrefix.currentPage', page);
  }

  Future<void> unlockNextBook(String keyPrefix) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$keyPrefix.isLocked', false);
    print("Next book unlocked for $keyPrefix!");
  }

  Future<String?> getNextBookKeyPrefix(String currentKeyPrefix) async {
    final prefs = await SharedPreferences.getInstance();

    List<Book> books = await getBooks();

    int currentBookIndex = books.indexWhere(
        (book) => 'book_${book.title.hashCode}' == currentKeyPrefix);

    if (currentBookIndex == -1) {
      return null;
    }

    for (int i = currentBookIndex + 1; i < books.length; i++) {
      final keyPrefix = 'book_${books[i].title.hashCode}';
      bool isLocked = prefs.getBool('$keyPrefix.isLocked') ?? true;
      if (isLocked) {
        return keyPrefix;
      }
    }

    return null;
  }
}
