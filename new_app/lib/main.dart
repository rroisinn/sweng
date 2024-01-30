
import 'package:new_app/example_candidate_model.dart';
import 'package:new_app/example_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:new_app/login.dart';
import 'package:new_app/database_helper.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  await initDatabase();


  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: LoginScreen(), // Add this line
      
      home: LoginPage()
    ),
  );
}

// Your initDatabase function call here
Future<void> initDatabase() async {
  await DatabaseHelper().initDatabase();
}

class Example extends StatefulWidget {
  const Example({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/example'; 

  @override
  State<Example> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<Example> {
  final CardSwiperController controller = CardSwiperController();

  final cards = candidates.map(ExampleCard.new).toList();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // back button on top of screen 
      appBar: AppBar( 
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
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
                    onPressed: controller.swipeLeft,
                    child: const Icon(Icons.close),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: CircleBorder(),
                  ),
                  FloatingActionButton(
                    onPressed: controller.undo,
                    child: const Icon(Icons.rotate_left),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: CircleBorder(), // Set the shape to CircleBorder
                  ),
                  FloatingActionButton(
                    onPressed: controller.swipeRight,
                    child: const Icon(Icons.done),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: CircleBorder(),
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