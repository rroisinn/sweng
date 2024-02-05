
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:new_app/example_candidate_model.dart';
import 'package:new_app/example_card.dart';
import 'package:new_app/login.dart';
import 'package:new_app/database_helper.dart';

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

  // final cards = candidates.map((candidate) => ExampleCard(candidate)).toList();
  final cards = candidates.map(ExampleCard.new).toList();


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
        builder: (context) => DetailsPage(candidate: candidate),
      ),
    );
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: CardSwiper(
                controller: controller,
                cardsCount: cards.length,
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
                    cards[index],
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
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                  FloatingActionButton(
                    heroTag: 'uniqueTag2',
                    onPressed: controller.undo,
                    child: const Icon(Icons.rotate_left),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                  FloatingActionButton(
                    heroTag: 'uniqueTag3',
                    onPressed: controller.swipeRight,
                    child: const Icon(Icons.done),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    
  }

  

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    if (direction == CardSwiperDirection.top) {
      // Navigate to the details page when swiped to the top
      _navigateToDetailsPage(cards[previousIndex!].candidate);
      return false;
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


