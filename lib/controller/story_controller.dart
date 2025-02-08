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
        totalPages: 14,
        totalQuizScore: 5,
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
              question: "What did Bennie learn from trying to move the big ball?",
              choices: {
                "A": "Balls can only roll downhill.",
                "B": "It takes force to make something move.",
                "C": "Small things are impossible to move.",
                "D": "You can only pull things, not push them."
              },
              correctFeedback: "🎉 Correct! Bennie learned that it takes force to make something move.",
              incorrectFeedback: "🚫 Not quite! Bennie discovered that force is needed to make objects move.",
              correctAnswer: 'B'),
          Quiz(
              question: "What kind of force was Bennie using when he tried to move the big ball?",
              choices: {
                "A": "Pulling",
                "B": "Jumping",
                "C": "Pushing",
                "D": "Throwing"
              },
              correctFeedback: "🎉 Great! Bennie was using pushing force to try and move the ball.",
              incorrectFeedback: "🚫 Almost! Bennie was pushing the ball, not pulling or throwing it.",
              correctAnswer: 'C'),
          Quiz(
              question: "Why was it easier for Sally to move the acorn compared to Bennie moving the big ball?",
              choices: {
                "A": "Sally is stronger than Bennie.",
                "B": "The acorn is smaller and lighter than the ball.",
                "C": "Acorns are made to roll.",
                "D": "Sally was using magic."
              },
              correctFeedback: "🎉 Exactly! Smaller and lighter objects require less force to move.",
              incorrectFeedback: "🚫 Nope! Sally was able to move the acorn easily because it's lighter and smaller than the ball.",
              correctAnswer: 'B'),
          Quiz(
              question: "What happens when something starts moving, according to Sally?",
              choices: {
                "A": "It stops immediately.",
                "B": "It keeps moving until something stops it.",
                "C": "It goes uphill by itself.",
                "D": "It disappears into the air."
              },
              correctFeedback: "🎉 Spot on! Objects in motion stay in motion until something stops them.",
              incorrectFeedback: "🚫 Not quite! Sally explained that objects move until a force stops them.",
              correctAnswer: 'B'),
          Quiz(
              question: "What did Tim the turtle say is the key to learning about force?",
              choices: {
                "A": "Pushing and pulling every day.",
                "B": "Reading books and staying curious.",
                "C": "Asking other animals to help.",
                "D": "Resting and watching from a distance."
              },
              correctFeedback: "🎉 That’s correct! Curiosity and learning are the keys to understanding force.",
              incorrectFeedback: "🚫 Close! Tim emphasized staying curious and learning to understand force.",
              correctAnswer: 'B'),
        ],
        audios: StoryAudio(
            ambient: "assets/audios/book2/ambient.mp3",
            introAudio: "assets/audios/book1/intro.mp3",
            audioPerPage: [
              "assets/audios/book1/intro.mp3",
              "assets/audios/book1/Vocal_Page1.Mp3",
              "assets/audios/book1/Vocal_Page2.Mp3",
              "assets/audios/book1/Vocal_Page3.Mp3",
              "assets/audios/book1/Vocal_Page4.Mp3",
              "assets/audios/book1/Vocal_Page5.Mp3",
              "assets/audios/book1/Vocal_Page6.Mp3",
              "assets/audios/book1/Vocal_Page7.Mp3",
              "assets/audios/book1/Vocal_Page8.Mp3",
              "assets/audios/book1/Vocal_Page9.Mp3",
              "assets/audios/book1/Vocal_Page10.Mp3",
              "assets/audios/book1/Vocal_Page11.Mp3",
              "assets/audios/book1/Vocal_Page12.Mp3",
            ]),
      ),
      Book(
        imageUrl: "assets/images/cover_books/lily.png",
        pdfPath: "assets/stories/lily.pdf",
        title: "Lily and The Swing",
        totalPages: 8,
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
              question: "What does Lily do to make the swing go higher?",
              choices: {
                "A": "She pulls the swing with her hands.",
                "B": "She pumps her legs to create force.",
                "C": "She waits for the wind to push her.",
                "D": "She jumps off the swing."
              },
              correctFeedback: "🎉 Great! Pumping her legs creates the force needed to make the swing go higher.",
              incorrectFeedback: "🚫 Not quite! She uses her legs to generate force, not her hands or the wind.",
              correctAnswer: 'B'),
          Quiz(
              question: "What is the force called that pulls Lily back down to the ground?",
              choices: {
                "A": "Gravity",
                "B": "Wind",
                "C": "Magnetism",
                "D": "Friction"
              },
              correctFeedback: "🎉 Correct! Gravity is the force that pulls objects down to Earth.",
              incorrectFeedback: "🚫 Oops! Remember, gravity is what makes objects fall.",
              correctAnswer: 'A'),
          Quiz(
              question: "What happens when Lily stops pumping her legs while swinging?",
              choices: {
                "A": "The swing stays in the air.",
                "B": "The swing keeps going higher.",
                "C": "The swing slows down and comes back down.",
                "D": "The swing spins in circles."
              },
              correctFeedback: "🎉 Well done! Without pumping, the swing slows and eventually stops.",
              incorrectFeedback: "🚫 Almost! The swing slows down because no force is added to keep it moving.",
              correctAnswer: 'C'),
          Quiz(
              question: "What does Lily's dad use as an example of gravity at work?",
              choices: {
                "A": "A kite flying in the sky",
                "B": "A leaf and a ball falling to the ground",
                "C": "A bird flying in the air",
                "D": "The wind blowing through the trees"
              },
              correctFeedback: "🎉 Excellent! A leaf and a ball show how gravity pulls objects down.",
              incorrectFeedback: "🚫 Not quite! Gravity is what pulls the leaf and ball to the ground.",
              correctAnswer: 'B'),
          Quiz(
              question: "What two forces are mentioned in the story that make Lily move on the swing?",
              choices: {
                "A": "Wind and gravity",
                "B": "Gravity and her force from pumping her legs",
                "C": "Magnetism and gravity",
                "D": "Friction and the wind"
              },
              correctFeedback: "🎉 Good job! Gravity and Lily’s effort make the swing move.",
              incorrectFeedback: "🚫 Oops! Think about how Lily creates motion and what pulls her back down.",
              correctAnswer: 'B'),
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
        totalPages: 10,
        totalQuizScore: 5,
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
            question: "What caused the papers to move in the story?",
            choices: {"A": "Milo’s hand", "B": "The wind", "C": "Lily’s toy cart", "D": "Zara’s foot"},
            correctFeedback: "🎉 The wind blows the papers away gently, making them flutter in the air.",
            incorrectFeedback: "🚫 The papers stay in place. Think about what naturally moves lightweight objects. Try again!",
            correctAnswer: 'B',
          ),
          Quiz(
            question: "What kind of motion did Lily show with her toy top?",
            choices: {"A": "Rolling motion", "B": "Spinning motion", "C": "Flying motion", "D": "Swinging motion"},
            correctFeedback: "🎉 The toy top spins faster with a glowing effect and a soft whirring sound.",
            incorrectFeedback: "🚫 The toy top doesn’t roll or fly. Think about how tops move. Try again!",
            correctAnswer: 'B',
          ),
          Quiz(
            question: "What did Lily use to show rolling motion?",
            choices: {"A": "A toy top", "B": "A ball", "C": "A swing", "D": "A paper plane"},
            correctFeedback: "🎉 The ball rolls smoothly with a ‘whoosh’ sound, showing rolling motion.",
            incorrectFeedback: "🚫 The object wobbles but doesn’t roll. Look for something that moves smoothly on the ground. Try again!",
            correctAnswer: 'B',
          ),
          Quiz(
            question: "How did Lily describe motion on the swing?",
            choices: {"A": "The swing was spinning.", "B": "The swing was moving back and forth.", "C": "The swing was rolling on the grass.", "D": "The swing was flying in the air."},
            correctFeedback: "🎉 The swing moves higher with a cheerful creaking sound, showing back-and-forth motion.",
            incorrectFeedback: "🚫 The swing stays still. Think about how swings move at the playground. Try again!",
            correctAnswer: 'B',
          ),
          Quiz(
            question: "What did Zara say motion is?",
            choices: {"A": "The way objects stand still.", "B": "The movement of objects, like rolling, spinning, or swinging.", "C": "The noise objects make when they move.", "D": "The colors of objects when they are still."},
            correctFeedback: "🎉 Objects move in different ways—rolling, spinning, or swinging. That’s motion!",
            incorrectFeedback: "🚫 Motion is all about movement! Think about what happens when objects move. Try again!",
            correctAnswer: 'B',
          ),
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
              "assets/audios/book3/Vocal_Page6.mp3",
              "assets/audios/book3/Vocal_Page7.mp3",
              "assets/audios/book3/Vocal_Page8.mp3",
            ]),
      ),
      Book(
        imageUrl: "assets/images/cover_books/mystical.png",
        pdfPath: "assets/stories/mystical.pdf",
        title: "Leo and The Mystical Cave",
        totalPages: 11,
        totalQuizScore: 5,
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
              correctAnswer: 'B'),
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
              correctAnswer: 'B'),
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
              correctAnswer: 'B'),
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
              correctAnswer: 'A'),
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
              correctAnswer: 'B'),
        ],
        audios: StoryAudio(
            ambient: "assets/audios/book2/ambient.mp3",
            introAudio: "assets/audios/book4/intro.mp3",
            audioPerPage: [
              "assets/audios/book4/intro.mp3",
              "assets/audios/book4/Vocal_Page1.MP3",
              "assets/audios/book4/Vocal_Page2.MP3",
              "assets/audios/book4/Vocal_Page3.MP3",
              "assets/audios/book4/Vocal_Page4.MP3",
              "assets/audios/book4/Vocal_Page5.MP3",
              "assets/audios/book4/Vocal_Page6.MP3",
              "assets/audios/book4/Vocal_Page7.MP3",
              "assets/audios/book4/Vocal_Page8.MP3",
              "assets/audios/book4/Vocal_Page9.MP3",
              "assets/audios/book4/Vocal_Page10.MP3",
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


        List<String> quizzesData = defaultBooks[i].quizzes.map((quiz) {
          final choices = quiz.choices.entries
              .map((entry) => "${entry.key}:${entry.value}")
              .join(";");
          return "${quiz.question}|$choices|${quiz.correctFeedback}|${quiz.incorrectFeedback}|${quiz.correctAnswer}";
        }).toList();
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
    List<String> quizzesData = prefs.getStringList('$keyPrefix.quizzes') ?? [];
    List<Quiz> quizzes = [];
    for (var quizString in quizzesData) {
      var parts = quizString.split('|');
      var choices = Map.fromEntries(parts[1].split(';').map((s) {
        var keyValue = s.split(':');
        return MapEntry(keyValue[0], keyValue[1]);
      }));
      quizzes.add(Quiz(
        question: parts[0],
        choices: choices,
        correctFeedback: parts[2],
        incorrectFeedback: parts[3],
        correctAnswer: parts[4],
      ));
    }

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

  Future<void> saveQuizScore(String keyPrefix, int score) async {
    final prefs = await SharedPreferences.getInstance();

    // Save the quiz score using the keyPrefix
    await prefs.setInt('$keyPrefix.quizScore', score);
    print("Quiz score saved for $keyPrefix: $score");
  }

  Future<int?> getQuizScore(String keyPrefix) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the quiz score using the keyPrefix
    int? score = prefs.getInt('$keyPrefix.quizScore');
    print("Quiz score for $keyPrefix: $score");
    return score;
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
