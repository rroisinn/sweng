import 'package:flutter/material.dart';
import 'package:new_app/database_helper.dart'; // Import the database helper
import 'package:new_app/example_candidate_model.dart'; 

class WishlistScreen extends StatefulWidget {
  final User? user; // Add a user parameter to the constructor
  const WishlistScreen({Key? key,required this.user}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late List<ExampleCandidateModel> wishlistItems = []; // Define the list of wishlist items

  @override
  void initState() {
    super.initState();
    // Load wishlist items from the database when the screen is initialized
    loadWishlistItems();
  }

  void loadWishlistItems() async {
     // Check if user is not null before accessing its id property
  final userId = widget.user?.id;
  debugPrint('User id: $userId');

  if (userId != null) {
    // Use the database helper to fetch wishlist items from the database
    wishlistItems = await DatabaseHelper().getWishlistItems(userId);
    setState(() {}); // Update the UI after loading wishlist items
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: wishlistItems.isEmpty
            ? Text('Your wishlist is currently empty.')
            : ListView.builder(
                itemCount: wishlistItems.length,
                itemBuilder: (context, index) {
                  final candidate = wishlistItems[index];
                  return ListTile(
                    title: Text(candidate.name),
                    subtitle: Text(candidate.brand),
                    // Add any other information you want to display
                  );
                },
              ),
      ),
    );
  }
}
