
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:new_app/example_candidate_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
// import 'package:super_text/super_text.dart';

class ExampleCard extends StatelessWidget {
  final ExampleCandidateModel candidate;

  const ExampleCard(
    this.candidate, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Container(
  clipBehavior: Clip.hardEdge,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 3,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: Stack(
    fit: StackFit.expand,
    children: [
      Image.network(
        candidate.image,
        fit: BoxFit.cover,
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.pink.withOpacity(0.7)
              ],
              stops: const [-0.1, 0.5],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                candidate.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Fill color
                ),
              ),
              const SizedBox(height: 5),
               // Add vertical padding
               Row(
                children: [
                  const Icon(
                    Icons.sell,
                    color: Colors.white,
                    size: 18, // Adjust size as needed
                  ),
                  const SizedBox(width: 5), // Add some spacing between the icon and text
                  Text(
                    candidate.brand,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              
              // const SizedBox(height: 0.5),
              // Padding(
              // padding: const EdgeInsets.symmetric(vertical: 0.5), // Add vertical padding
              Row(
                children: [
                  const Icon(
                    Icons.paid,
                    color: Colors.white,
                    size: 18, // Adjust size as needed
                  ),
                  const SizedBox(width: 5),
                  Text(
                    candidate.price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  // const SizedBox(width: 10), // Add some spacing between the price and button
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      _launchURL(candidate.link);
                    },
                    icon: const Icon(
                      Icons.link,
                    color: Colors.pink,),
                    label:const  Text(
                        'Open in shop',
                        style: TextStyle(
                          color: Colors.pink, // Change the color to pink
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
);


  }

  // Function to launch URL
  // Function to launch URL
Future<void> _launchURL(String url) async {
  // const url2 = "https://flutter.io";
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
}

class DetailsPage extends StatelessWidget {
  final ExampleCandidateModel candidate;
  final CardSwiperController? controller;
  // final CardSwiperController controller = CardSwiperController();

  const DetailsPage({Key? key, required this.candidate, this.controller}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                candidate.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.pink.withOpacity(0.7),
                    Colors.white,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Additional Details:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        candidate.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.sell,
                            color: Colors.white,
                            size: 18, // Adjust size as needed
                          ),
                          const SizedBox(width: 5), // Add some spacing between the icon and text
                          Text(
                            candidate.brand,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.paid,
                            color: Colors.white,
                            size: 18, // Adjust size as needed
                          ),
                          const SizedBox(width: 5),
                          Text(
                            candidate.price,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _launchURL(candidate.link);
                        },
                        icon: const Icon(
                          Icons.link,
                          color: Colors.pink,
                        ),
                        label: const Text(
                          'Open in shop',
                          style: TextStyle(
                            color: Colors.pink, // Change the color to pink
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (controller != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          heroTag: 'uniqueTag1',
                          onPressed:(){controller!.swipeLeft(); Navigator.pop(context);},
                          child: Icon(Icons.close),
                          backgroundColor: Color.fromARGB(255, 241, 85, 137),
                          foregroundColor: Colors.white,
                          shape: CircleBorder(),
                        ),
                        FloatingActionButton(
                          heroTag: 'uniqueTag2',
                          onPressed:(){controller!.undo(); Navigator.pop(context);
                          },
                          child: Icon(Icons.rotate_left),
                          backgroundColor: Color.fromARGB(255, 241, 85, 137),
                          foregroundColor: Colors.white,
                          shape: CircleBorder(),
                        ),
                        FloatingActionButton(
                          heroTag: 'uniqueTag3',
                          onPressed: (){controller!.swipeRight(); Navigator.pop(context);},
                          child: Icon(Icons.done),
                          backgroundColor: Color.fromARGB(255, 241, 85, 137),
                          foregroundColor: Colors.white,
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}




