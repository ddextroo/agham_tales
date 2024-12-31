import 'package:agham_tales/model/quiz.dart';
import 'package:agham_tales/model/story_audio.dart';
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
        quizzes: [
          Quiz(
              question: "What kind of force is Bennie using to move the ball?",
              choices: {"A": "Push", "B": "Pull"},
              correctFeedback:
                  "🎉 That’s right! Bennie is using push force to move the ball!",
              incorrectFeedback:
                  "🚫 Not quite! Bennie is pushing, not pulling the ball.",
              correctAnswer: ['A']),
          Quiz(
              question:
                  "Why is it easier for Sally to push the acorn than Bennie to push the ball?",
              choices: {
                "A": "The ball is lighter than the acorn.",
                "B": "The ball is heavier than the acorn."
              },
              correctFeedback:
                  "🎉 Good job! Heavier objects need more force to move.",
              incorrectFeedback:
                  "🚫 Oops! The ball is heavier, so it’s harder to push.",
              correctAnswer: ['B']),
          Quiz(
              question: "What kind of force is Rico using to move the cart?",
              choices: {"A": "Push", "B": "Pull"},
              correctFeedback:
                  "🎉 Great! Rico is pulling the cart using pull force!",
              incorrectFeedback:
                  "🚫 Not quite! Rico is using pull force, not push force.",
              correctAnswer: ['B']),
          Quiz(
              question:
                  "Why was the ball easier to move when everyone helped push?",
              choices: {
                "A": "They used more force together.",
                "B": "The ball got lighter."
              },
              correctFeedback:
                  "🎉 You got it! More force makes it easier to move heavy things.",
              incorrectFeedback:
                  "🚫 Almost! The ball didn’t get lighter—they just used more force together.",
              correctAnswer: ['A']),
          Quiz(
              question: "Why did the ball stop moving?",
              choices: {
                "A": "Tim used force to stop it.",
                "B": "It stopped on its own."
              },
              correctFeedback:
                  "🎉 Correct! Something, like Tim or the ground, must apply force to stop motion.",
              incorrectFeedback:
                  "🚫 Not quite! The ball stops because something applies force to it.",
              correctAnswer: ['A']),
        ],
        audios: StoryAudio(introAudio: "", audioPerPage: []),
      ),
      Book(
        imageUrl: "assets/images/cover_books/lily.png",
        pdfPath: "assets/stories/lily.pdf",
        title: "Lily and The Swing",
        totalPages: 7,
        totalQuizScore: 5,
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
        quizzes: [
          Quiz(
              scene:
                  "Players are shown three scenes: a ball falling, a leaf drifting down, and a kite flying.",
              question: "Tap all the objects that are affected by gravity.",
              choices: {"A": "Ball", "B": "Leaf", "C": "Kite"},
              correctFeedback:
                  "🎉 Great! Gravity pulls the ball and leaf to the ground!",
              incorrectFeedback:
                  "🚫 Hmm, remember, gravity pulls things down. Try again!",
              correctAnswer: ['A', 'B']),
          Quiz(
              scene:
                  "Players see Lily pushing a swing, pulling a wagon, and kicking a ball.",
              question: "Tap the correct label (Push or Pull) for each action.",
              choices: {
                "A": "Swing: Push",
                "B": "Wagon: Pull",
                "C": "Ball: Push"
              },
              correctFeedback:
                  "🎉 Well done! The objects move as expected, thanks to the right labels!",
              incorrectFeedback:
                  "🚫 Not quite! Think about whether Lily is pushing something away or pulling it closer.",
              correctAnswer: ['A']),
          Quiz(
              scene:
                  "Players drag action words to match animated objects on the screen.",
              question:
                  "Match the motion! Drag the correct labels to the objects.",
              choices: {
                "A": "Swinging → Swing",
                "B": "Falling → Leaf",
                "C": "Rolling → Ball",
                "D": "Spinning → Top"
              },
              correctFeedback:
                  "🎉 Excellent! The matches show how objects move.",
              incorrectFeedback:
                  "🚫 Oops! Look closely at how the object moves and try again!",
              correctAnswer: ['A']),
          Quiz(
              scene: "A short multiple-choice quiz about gravity.",
              question:
                  "What force pulls you back to the ground when you jump?",
              choices: {"A": "Gravity", "B": "Wind", "C": "Push"},
              correctFeedback: "🎉 You got it! Gravity pulls us down to Earth.",
              incorrectFeedback:
                  "🚫 Uh-oh! Remember, gravity is the force pulling objects down.",
              correctAnswer: ['A']),
          Quiz(
              scene: "A short multiple-choice quiz about gravity.",
              question: "Which way does gravity pull objects?",
              choices: {"A": "Up", "B": "Down", "C": "Sideways"},
              correctFeedback: "🎉 Correct! Gravity always pulls objects down.",
              incorrectFeedback:
                  "🚫 Not quite! Gravity works in a downward direction.",
              correctAnswer: ['A']),
          Quiz(
              scene: "Players arrange items to create a force chain reaction.",
              question: "Arrange the items to make a force chain reaction!",
              choices: {
                "A": "Ball → Ramp → Dominoes → Swing",
                "B": "Swing → Dominoes → Ramp → Ball",
                "C": "Dominoes → Ball → Swing → Ramp"
              },
              correctFeedback: "🎉 Awesome! That’s how force works!",
              incorrectFeedback:
                  "🚫 Hmm, try putting the ramp first for the ball to roll!",
              correctAnswer: ['A'])
        ],
        audios: StoryAudio(
            ambient: "assets/audios/book2/ambient.mp3",
            introAudio: "assets/audios/book2/intro.mp3",
            audioPerPage: [
              "assets/audios/book2/intro.mp3",
              "assets/audios/book2/Vocal1_Pg2.mp3",
              "assets/audios/book2/Vocal2_Pg3.mp3",
              "assets/audios/book2/Vocal3_Pg4.mp3",
              "assets/audios/book2/Vocal4_Pg5.mp3",
              "assets/audios/book2/Vocal5_Pg6.mp3",
              "assets/audios/book2/Vocal6_Pg7.mp3",
            ]),
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
            word: "discover",
            definition: "Find something new.",
            pronunciation: "/dɪˈskʌv.ər/ or /dɪˈskʌv.ərd/",
            partOfSpeech: "Verb",
          ),
          "discovered": Dictionary(
            word: "discovered",
            definition: "Find something new.",
            pronunciation: "/dɪˈskʌv.ər/ or /dɪˈskʌv.ərd/",
            partOfSpeech: "Verb",
          ),
        },
        quizzes: [
          Quiz(
              question: "What motion is the paper plane showing?",
              choices: {"A": "Flying", "B": "Rolling", "C": "Spinning"},
              correctFeedback:
                  "🎉 The paper plane glides offscreen with a 'Whoosh!' sound and a glowing trail.",
              incorrectFeedback:
                  "🚫 The paper plane wobbles and falls to the ground with a funny 'thud' sound. Oops! Paper planes fly through the air. Try again!",
              correctAnswer: ['A']),
          Quiz(
              question: "Help Lily find her toy cart!",
              choices: {"A": "Ball", "B": "Spinning Top", "C": "Toy Cart"},
              correctFeedback:
                  "🎉 The toy cart rolls to Lily with a cheerful sound, and Lily waves.",
              incorrectFeedback:
                  "🚫 If the wrong object is dragged, it wobbles and bounces back to its original spot. Hmm, the cart rolls. Try again!",
              correctAnswer: ['C']),
          Quiz(
              question: "What motion does a swing show?",
              choices: {"A": "Back-and-Forth", "B": "Spinning", "C": "Flying"},
              correctFeedback:
                  "🎉 The swing moves faster with a fun creaking sound, and cheerful kids appear in the background.",
              incorrectFeedback:
                  "🚫 The swing slows down and stops briefly. Not quite! Swings go back and forth. Try again!",
              correctAnswer: ['A']),
          Quiz(
              question: "Zara is curious: What makes the spinning top move?",
              choices: {"A": "Push", "B": "Wind", "C": "Rolling"},
              correctFeedback:
                  "🎉 The top glows and spins faster, with sparkles around it.",
              incorrectFeedback:
                  "🚫 The top slows down and tilts slightly. Hmm, think about what made the top start moving. Try again!",
              correctAnswer: ['A']),
          Quiz(
              question:
                  "Milo wonders: Which of these objects shows rolling motion?",
              choices: {"A": "Ball", "B": "Kite", "C": "Spinning Top"},
              correctFeedback:
                  "🎉 The ball rolls offscreen with a 'Ta-da!' sound, and a mini fireworks animation appears.",
              incorrectFeedback:
                  "🚫 The incorrect object wiggles and stays in place. Look for something that rolls. Try again!",
              correctAnswer: ['A']),
        ],
        audios: StoryAudio(
            ambient: "assets/audios/book2/ambient.mp3",
            introAudio: "assets/audios/book3/intro.mp3",
            audioPerPage: [
              "assets/audios/book3/intro.mp3",
              "assets/audios/book3/Vocal_Page1.mp3",
              "assets/audios/book3/Vocal_Page2.mp3",
              "assets/audios/book3/Vocal_Page3.mp3",
              "assets/audios/book3/Vocal_Page4.mp3",
              "assets/audios/book3/Vocal_Page5.mp3",
              "assets/audios/book3/Vocal_Page7.mp3",
              "assets/audios/book3/Vocal_Page7.mp3",
              "assets/audios/book3/Vocal_Page8.mp3",
            ]),
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
            word: "bounced",
            definition: "To hit and come back.",
            pronunciation: "/baʊns/",
            partOfSpeech: "Verb",
          ),
          "bounces": Dictionary(
            word: "bounces",
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
        quizzes: [
          Quiz(
              question: "Why is the cave colder than outside?",
              choices: {
                "A": "The cave has an air conditioner.",
                "B": "The cave doesn’t get sunlight, so it stays cool.",
                "C": "The cave is full of ice.",
                "D": "The cave makes cold air by itself."
              },
              correctFeedback:
                  "🎉 Correct! The cave doesn’t get sunlight, so it stays naturally cool.",
              incorrectFeedback:
                  "🚫 Not quite! The cave stays cool because it doesn’t get sunlight.",
              correctAnswer: ['B']),
          Quiz(
              question: "Why does the sound echo in the cave?",
              choices: {
                "A": "The cave is copying the sound.",
                "B": "The sound bounces off the cave walls and comes back.",
                "C": "There’s a secret speaker in the cave.",
                "D": "The cave walls eat the sound and throw it back."
              },
              correctFeedback:
                  "🎉 That’s right! The sound bounces off the cave walls and comes back as an echo.",
              incorrectFeedback:
                  "🚫 Nope! Echoes happen because sound bounces off the cave walls and comes back.",
              correctAnswer: ['B']),
          Quiz(
              question: "What helps Leo see in the dark cave?",
              choices: {
                "A": "The heat from the flashlight.",
                "B": "The light from the flashlight.",
                "C": "The sound of the echo.",
                "D": "The cold air inside the cave."
              },
              correctFeedback:
                  "🎉 Correct! The light from the flashlight helps Leo see in the dark cave.",
              incorrectFeedback:
                  "🚫 Not quite! It’s the light from the flashlight that helps Leo see.",
              correctAnswer: ['B']),
          Quiz(
              question: "What two kinds of energy does a candle have?",
              choices: {
                "A": "Light energy and heat energy.",
                "B": "Sound energy and heat energy.",
                "C": "Light energy and echo energy.",
                "D": "Cold energy and sound energy."
              },
              correctFeedback:
                  "🎉 You got it! A candle produces light energy and heat energy.",
              incorrectFeedback:
                  "🚫 Nope! Candles give off light energy and heat energy.",
              correctAnswer: ['A']),
          Quiz(
              question: "What did Leo learn by the end of the story?",
              choices: {
                "A": "Caves are full of energy!",
                "B":
                    "Different kinds of energy, like heat, light, and sound, can be found everywhere.",
                "C": "Flashlights are better than candles.",
                "D": "It’s fun to clap in a cave!"
              },
              correctFeedback:
                  "🎉 Correct! Leo learned that different kinds of energy, like heat, light, and sound, can be found everywhere.",
              incorrectFeedback:
                  "🚫 Not quite! Leo discovered that energy is all around us in different forms like heat, light, and sound.",
              correctAnswer: ['B']),
        ],
        audios: StoryAudio(
            ambient: "assets/audios/book2/ambient.mp3",
            introAudio: "assets/audios/book4/intro.mp3",
            audioPerPage: [
              "assets/audios/book4/intro.mp3",
              // "assets/audios/book4/Vocal_Page1.m4a",
              "assets/audios/book4/Vocal_Page2.m4a",
              "assets/audios/book4/Vocal_Page3.m4a",
              "assets/audios/book4/Vocal_Page4.m4a",
              "assets/audios/book4/Vocal_Page5.m4a",
              "assets/audios/book4/Vocal_Page6.m4a",
              "assets/audios/book4/Vocal_Page7.m4a",
              "assets/audios/book4/Vocal_Page8.m4a",
              "assets/audios/book4/Vocal_Page9.m4a",
              "assets/audios/book4/Vocal_Page10.m4a",
            ]),
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
        await prefs.setInt('$keyPrefix.totalQuizScore', defaultBooks[i].totalQuizScore);

        // Save glossary data
        List<String> glossaryData = defaultBooks[i]
            .glossary
            .values
            .map((dict) =>
        "${dict.word}|${dict.definition}|${dict.pronunciation}|${dict.partOfSpeech}")
            .toList();
        await prefs.setStringList('$keyPrefix.glossary', glossaryData);

        // Save quizzes data
        List<String> quizzesData = defaultBooks[i]
            .quizzes
            .map((quiz) =>
        "${quiz.scene}|${quiz.question}|${quiz.choices.toString()}|${quiz.correctFeedback}|${quiz.incorrectFeedback}|${quiz.correctAnswer.join(',')}")
            .toList();
        await prefs.setStringList('$keyPrefix.quizzes', quizzesData);

        // Save audio data
        await prefs.setString('$keyPrefix.audio.ambientAudio', defaultBooks[i].audios.ambient ?? "");
        await prefs.setString('$keyPrefix.audio.introAudio', defaultBooks[i].audios.introAudio);
        await prefs.setStringList('$keyPrefix.audio.audioPerPage', defaultBooks[i].audios.audioPerPage);
      }

      // Load the book state including glossary, quizzes, and audio
      final book = await loadBookState(keyPrefix);
      if (book.title.isNotEmpty) {
        defaultBooks[i] = book;
      }
    }

    return defaultBooks;
  }

  Future<Book> loadBookState(String keyPrefix) async {
    final prefs = await SharedPreferences.getInstance();

    // Load glossary data
    List<String> glossaryData = prefs.getStringList('$keyPrefix.glossary') ?? [];
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

    // Load quizzes
    List<String> quizData = prefs.getStringList('$keyPrefix.quizzes') ?? [];
    List<Quiz> quizzes = quizData.map((quizEntry) {
      final parts = quizEntry.split('|');
      if (parts.length >= 6) {
        final scene = parts[0];
        final question = parts[1];
        final choices = Map<String, String>.fromEntries(
          parts[2].split(';').map((choice) {
            final choiceParts = choice.split(':');
            return MapEntry(choiceParts[0], choiceParts[1]);
          }),
        );
        final correctFeedback = parts[3];
        final incorrectFeedback = parts[4];
        final correctAnswer = parts[5].split(',');
        return Quiz(
          scene: scene,
          question: question,
          choices: choices,
          correctFeedback: correctFeedback,
          incorrectFeedback: incorrectFeedback,
          correctAnswer: correctAnswer,
        );
      }
      return null;
    }).whereType<Quiz>().toList();

    // Load audio data
    String? ambient = prefs.getString('$keyPrefix.audio.ambientAudio');
    String? introAudio = prefs.getString('$keyPrefix.audio.introAudio');
    List<String> audioPerPage =
        prefs.getStringList('$keyPrefix.audio.audioPerPage') ?? [];

    // Return Book object
    return Book(
      imageUrl: prefs.getString('$keyPrefix.imageUrl') ?? '',
      pdfPath: prefs.getString('$keyPrefix.pdfPath') ?? '',
      title: prefs.getString('$keyPrefix.title') ?? '',
      isLocked: prefs.getBool('$keyPrefix.isLocked') ?? true,
      currentPage: prefs.getInt('$keyPrefix.currentPage') ?? 1,
      totalPages: prefs.getInt('$keyPrefix.totalPages') ?? 0,
      quizScore: prefs.getInt('$keyPrefix.quizScore') ?? 0,
      totalQuizScore: prefs.getInt('$keyPrefix.totalQuizScore') ?? 0,
      glossary: glossary,
      quizzes: quizzes,
      audios: StoryAudio(
        ambient: ambient ?? '',
        introAudio: introAudio ?? '',
        audioPerPage: audioPerPage,
      ),
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

    final keyPrefix = 'book_${books[currentBookIndex + 1].title.hashCode}';
    print(keyPrefix);
    bool isLocked = prefs.getBool('$keyPrefix.isLocked') ?? true;
    if (isLocked) {
      return keyPrefix;
    }

    return null;
  }
}
