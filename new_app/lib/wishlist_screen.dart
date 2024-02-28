
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:new_app/database_helper.dart';
import 'package:new_app/example_candidate_model.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:new_app/account_page.dart';

class WishlistScreen extends StatefulWidget {
  final User? user;

  const WishlistScreen({Key? key, required this.user}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late List<ExampleCandidateModel> wishlistItems = [];

  @override
  void initState() {
    super.initState();
    loadWishlistItems();
  }

  void loadWishlistItems() async {
    final userId = widget.user?.id;
    debugPrint('User id: $userId');

    if (userId != null) {
      wishlistItems = await DatabaseHelper().getWishlistItems(userId);
      setState(() {}); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      
                      Image.asset(
                        'assets/logo.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 18),
                      const Text(
                        'Wishlist',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                ),
                
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountPage()),
                    );
                  },
                ),
              ],
            ),
          ),
      body: Center(
        child: wishlistItems.isEmpty
            ? Text('Your wishlist is currently empty.')
            : ListView.builder(
                itemCount: wishlistItems.length,
                itemBuilder: (context, index) {
                  final candidate = wishlistItems[index];
                  final isOddIndex = index.isOdd;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (isOddIndex)
                          _buildDetailsContainer(candidate),
                        _buildImageContainer(candidate),
                        if (!isOddIndex)
                          _buildDetailsContainer(candidate),
                      ],
                    ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildImageContainer(ExampleCandidateModel candidate) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.network(
          candidate.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildDetailsContainer(ExampleCandidateModel candidate) {
    return Expanded(
      flex: 1,
    
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              candidate.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            // Text(candidate.brand),
            Row(
                children: [
                  const Icon(
                    Icons.sell,
                    color: Colors.black,
                    size: 18, // Adjust size as needed
                  ),
                  const SizedBox(width: 5), // Add some spacing between the icon and text
                  Text(
                    candidate.brand,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  const Icon(
                    Icons.paid,
                    color: Colors.black,
                    size: 18, // Adjust size as needed
                  ),
                  const SizedBox(width: 5),
                  Text(
                    candidate.price,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
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
      ),
    );
  }
}



Future<void> _launchURL(String url) async {
  // const url2 = "https://flutter.io";
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}


