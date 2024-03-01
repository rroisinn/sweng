
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:new_app/example_candidate_model.dart';
import 'package:new_app/example_card.dart';
import 'package:new_app/account_page.dart';
import 'package:new_app/login.dart';
import 'package:new_app/wishlist_screen.dart';
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
      home: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
   final User? user;

  const MyApp({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',  // Set initial route to login
      routes: {
        '/login': (context) => const LoginPage(),
        '/example': (context) => Example(user: user),
        '/wishlist': (context) => WishlistScreen(user: user),
        '/account': (context) => AccountPage(user: user),
      },
    );
  }
}

// Your initDatabase function call here
Future<void> initDatabase() async {
  await DatabaseHelper().initDatabase();
}



class Example extends StatefulWidget {
  // const Example({Key? key}) : super(key: key);
  final User? user;
  const Example({Key? key, this.user}) : super(key: key);

  static const String routeName = '/example';

  

  @override
  State<Example> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<Example> {
  final CardSwiperController controller = CardSwiperController();
  int currentIndex = 0;
  

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
  
  debugPrint('currentIndex: $currentIndex');
  // Generate a unique URL for the card
  String cardUrl = candidate.link;
  
  // Share the URL
  Share.share('Check out this item I found on SWENG!: \n$cardUrl');
}

Future <Preference?> getUserPreferences() async {
  try {
    final DatabaseHelper databaseHelper = DatabaseHelper();
    final User? user1 = ModalRoute.of(context)?.settings.arguments as User?;

    return await databaseHelper.getPref(user1!.username);
    
  } catch (e) {
    debugPrint('Error getting user preferences: $e');
    // Handle the error gracefully
  }
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
          brand: item['brand'],
        );
      }).toList();
      
      // Retrieve user preferences
      Preference? pref = await getUserPreferences();
      
      // Filter candidates based on user preferences
      final filteredCandidates = parsedCandidates.where((candidate) =>
          candidate.name.toLowerCase().contains(pref!.preference1.toLowerCase()) ||
          candidate.name.toLowerCase().contains(pref.preference2.toLowerCase()) ||
          candidate.name.toLowerCase().contains(pref.preference3.toLowerCase()) ||
          candidate.name.toLowerCase().contains(pref.preference4.toLowerCase())
      ).toList();

      // Insert filtered candidates to the start of the list
      candidates.insertAll(0, filteredCandidates);

      // Check if the list size is at least 10
      if (candidates.length < 5) {
        // Fill the remaining slots with additional candidates fetched from the API
        final remainingCandidates = parsedCandidates.where((candidate) => !filteredCandidates.contains(candidate)).toList();
        candidates.addAll(remainingCandidates.take(10 - candidates.length));
      }

      return candidates;
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
    final User? user1 = ModalRoute.of(context)?.settings.arguments as User?;
    
    return Scaffold(
      appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.transparent,
  automaticallyImplyLeading: false,
  
  title: Image.asset(
          'assets/logo.png', // Path to your logo image
          width: 100, // Adjust the width as needed
          height: 100, // Adjust the height as needed
          fit: BoxFit.contain, // Ensure the logo fits within the app bar
        ),
        // centerTitle: true, // Center the logo horizontally
  actions: <Widget>[
    // IconButton for sharing
    IconButton(
      icon: const Icon(Icons.share),
      onPressed: () {
        _shareContent();
      },
    ),
    // IconButton for wishlist
    IconButton(
      icon: const Icon(Icons.favorite_border),
      onPressed: () {
        if (user1 != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WishlistScreen(user: user1!), // Pass the user object
            ),
          );
        } else {
          debugPrint('User not found!');
        }
      },
    ),
    // IconButton for account
    IconButton(
      icon: const Icon(Icons.account_circle),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountPage(user:user1)),
        );
      },
    ),
  ],
),

      
      body: SafeArea(
        
        child: FutureBuilder<List<ExampleCandidateModel>>(
          future: futureCandidates,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              candidates = snapshot.data ?? [];
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
            padding: const EdgeInsets.all(15.0),
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
                backgroundColor: const Color.fromARGB(255, 241, 85, 137),
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
              ),
              FloatingActionButton(
                heroTag: 'uniqueTag3',
                onPressed: controller.swipeRight,
                child: const Icon(Icons.favorite),
                backgroundColor: const Color.fromARGB(255, 241, 85, 137),
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
              ),
            ],
          ),
        ),
      ],
    );
  }




  int swipeCount = 0;

  bool _onSwipe(
  int previousIndex,
  int? currentIndex,
  CardSwiperDirection direction,
) {
  debugPrint(
    'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
  );

  final User? user1 = ModalRoute.of(context)?.settings.arguments as User?;

  if (direction == CardSwiperDirection.top) {
    // Navigate to the details page when swiped to the top
    _navigateToDetailsPage(candidates[previousIndex!]);
    return false;
  } else if (direction == CardSwiperDirection.left) {
    fetchAndAddRandom();
    controller.swipeLeft(); // Handle left swipe
    if (currentIndex != null) {
      this.currentIndex = currentIndex;
    }
  } else if (direction == CardSwiperDirection.right) {
    fetchAndAddRecommendation(candidates[previousIndex!]);
    addToWishlist(candidates[previousIndex!], user1);
    controller.swipeRight(); // Handle right swipe
    if (currentIndex != null) {
      this.currentIndex = currentIndex;
    }
  }

  debugPrint('New currentIndex: $currentIndex');
  debugPrint('Candidates length: ${candidates.length}');

  return true;
}



  void addToWishlist(ExampleCandidateModel candidate, User? user) async {
  // Obtain the user ID from the database or any other source
  if (user != null) {
    final DatabaseHelper databaseHelper = DatabaseHelper();
    // Check if the item is already in the wishlist
    final existingItems = await databaseHelper.getWishlistItems(user.id);
    for (var item in existingItems) {
       if (item == candidate) {
          debugPrint('Item already exists in the wishlist!');
          return;
        }
    
    
    }
    // If the item is not in the wishlist, add it
    databaseHelper.insertWishlistItem(user.id, candidate);
    debugPrint('Item added to wishlist!');

    } 
  }
  




  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undid from the ${direction.name}',
    );
    if (currentIndex != null) {
      this.currentIndex = currentIndex;
    }
    return true;
  }
  
  void fetchAndAddRecommendation(ExampleCandidateModel candidate) async{
    
  try {
    // Construct URL for recommendation
    String recommendationUrl = 'https://sweng1.pythonanywhere.com/recommend/${candidate.name}';
    // Fetch recommendation from the URL
    final response = await http.get(Uri.parse(recommendationUrl));
    if (response.statusCode == 200) {
      // Parse the JSON data
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      // Create an ExampleCandidateModel instance from the recommendation data
      ExampleCandidateModel recommendation = ExampleCandidateModel(
        name: jsonData['name'],
        image: jsonData['image'],
        link: jsonData['link'],
        price: jsonData['price'],
        brand: jsonData['brand'],
      );
      // Add the recommendation to the list of cards
      if (!candidates.contains(recommendation)) {
          // Add the recommendation to the list of cards
          setState(() {
            candidates.add(recommendation);
          });
        }
    } else {
      throw Exception('Failed to load recommendation: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error fetching recommendation: $e');
    // Handle the error gracefully, e.g., show a friendly error message to the user
  }

  }
  void fetchAndAddRandom() async {
  try {
    // Construct URL for recommendation with query parameter for number of items
    String randomUrl = 'https://sweng1.pythonanywhere.com/random';
    // Fetch recommendation from the URL
    final response = await http.get(Uri.parse(randomUrl));
    if (response.statusCode == 200) {
      // Parse the JSON data
      final List<dynamic> jsonDataList = jsonDecode(response.body);
      // Iterate over the JSON data list and create ExampleCandidateModel instances
      for (var jsonData in jsonDataList) {
        ExampleCandidateModel random = ExampleCandidateModel(
          name: jsonData['name'],
          image: jsonData['image'],
          link: jsonData['link'],
          price: jsonData['price'],
          brand: jsonData['brand'],
        );
        if (!candidates.contains(random)) {
        // Add the recommendation to the list of cards
        setState(() {
          candidates.add(random);
        });
      }
      }
    }else {
      throw Exception('Failed to load random items: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error fetching recommendation: $e');
    // Handle the error gracefully, e.g., show a friendly error message to the user
  }
}




}


