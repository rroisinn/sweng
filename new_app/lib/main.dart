
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:new_app/example_candidate_model.dart';
import 'package:new_app/example_card.dart';
import 'package:new_app/login.dart';
import 'package:new_app/database_helper.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the database
  await initDatabase();
  

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Example(),
      home: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',  // Set initial route to login
      routes: {
        '/login': (context) => LoginPage(),
        '/example': (context) => const Example(),
      },
    );
  }
}

// Your initDatabase function call here
Future<void> initDatabase() async {
  await DatabaseHelper().initDatabase();
}



class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  static const String routeName = '/example';

  @override
  State<Example> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<Example> {
  final CardSwiperController controller = CardSwiperController();
  int currentIndex = 0;
  // List<ExampleCandidateModel> candidates = [];

  late Future<List<ExampleCandidateModel>> futureCandidates;
  late List<ExampleCandidateModel> candidates; // Define candidates here

  @override
  void initState() {
    super.initState();
    futureCandidates = fetchData();
    candidates = [];
  }

    @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  void _navigateToDetailsPage(ExampleCandidateModel candidate) {
     // Update selectedCardIndex
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(candidate: candidate, controller: controller),
      ),
    );
  }

  // Define the _shareContent function to share the content
  void _shareContent() {
  // Get the candidate at the specified index
  ExampleCandidateModel candidate = candidates[currentIndex];
  
  // Generate a unique URL for the card
  String cardUrl = 'https://yourdomain.com/card?name=${candidate.name}';
  
  // Share the URL
  Share.share('Check out this candidate:\n$cardUrl');
}

  Future<List<ExampleCandidateModel>> fetchData() async {
    try {
      // Fetch JSON data from the URL
      final response = await http.get(Uri.parse('https://sweng1.pythonanywhere.com'));
      if (response.statusCode == 200) {
        // Parse the JSON data
        final List<dynamic> jsonData = jsonDecode(response.body);

        // Create a list of ExampleCandidateModel instances
        final List<ExampleCandidateModel> parsedCandidates = jsonData.map((item) {
          return ExampleCandidateModel(
            name: item['name'],
            image: item['image'],
            link: item['link'],
            price: item['price'],
          );
        }).toList();

        return parsedCandidates;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle the error gracefully, e.g., show a friendly error message to the user
      return []; // Return an empty list if an error occurs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          // Add an IconButton for sharing
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareContent();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<ExampleCandidateModel>>(
          future: futureCandidates,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              candidates = snapshot.data ?? []; // Update candidates list here
              return _buildCardSwiper(candidates);
            }
          },
          
        ),
      ),
    );
  }

  Widget _buildCardSwiper(List<ExampleCandidateModel> candidates) {
    return Column(
      children: [
        Flexible(
          child: CardSwiper(
            controller: controller,
            cardsCount: candidates.length,
            onSwipe: _onSwipe,
            onUndo: _onUndo,
            numberOfCardsDisplayed: 3,
            backCardOffset: const Offset(40, 40),
            padding: const EdgeInsets.all(24.0),
            cardBuilder: (
              context,
              index,
              horizontalThresholdPercentage,
              verticalThresholdPercentage,
            ) =>
                ExampleCard(candidates[index]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'uniqueTag1',
                onPressed: controller.swipeLeft,
                child: const Icon(Icons.close),
                backgroundColor: const Color.fromARGB(255, 241, 85, 137),
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
              ),
              FloatingActionButton(
                heroTag: 'uniqueTag2',
                onPressed: controller.undo,
                child: const Icon(Icons.rotate_left),
                backgroundColor: Color.fromARGB(255, 241, 85, 137),
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
              ),
              FloatingActionButton(
                heroTag: 'uniqueTag3',
                onPressed: controller.swipeRight,
                child: const Icon(Icons.favorite),
                backgroundColor: Color.fromARGB(255, 241, 85, 137),
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
              ),
            ],
          ),
        ),
      ],
    );
  }


 

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    setState(() {
    this.currentIndex = currentIndex ?? previousIndex;
    });

    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );

    // debugPrint('Length of candidates list: ${candidates.length}');

    if (direction == CardSwiperDirection.top) {
      // Navigate to the details page when swiped to the top
      _navigateToDetailsPage(candidates[previousIndex!]);
      return false;
    }
    else if (direction == CardSwiperDirection.left) {
    controller.swipeLeft(); // Handle left swipe
  } else if (direction == CardSwiperDirection.right) {
    controller.swipeRight(); // Handle right swipe
  }
    return true;

  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}


