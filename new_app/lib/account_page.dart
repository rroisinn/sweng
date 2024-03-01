import 'package:flutter/material.dart';
import 'package:new_app/database_helper.dart';
// import 'package:new_app/example_candidate_model.dart'; 
import 'package:new_app/preference.dart';
import 'package:new_app/wishlist_screen.dart'; 

class AccountPage extends StatefulWidget {
  final User? user;

  const AccountPage({Key? key, required this.user}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late String? email;
  late String pref1 = '';
  late String pref2 = '';
  late String pref3 = '';
  late String pref4 = '';
  
  @override
  void initState() {
    super.initState();
    loadAccountDetails();
  }

  void loadAccountDetails() async {
    email = widget.user?.username;
    debugPrint('User email: $email');

    final DatabaseHelper databaseHelper = DatabaseHelper();
    Preference? preference = await databaseHelper.getPref(widget.user!.username);
    if (preference != null) {
      setState(() {
        pref1 = preference.preference1;
        pref2 = preference.preference2;
        pref3 = preference.preference3;
        pref4 = preference.preference4;
      });
      debugPrint('Preferences: $pref1, $pref2, $pref3, $pref4');
    } else {
      debugPrint('Preferences not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user1 = widget.user;
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
                        'My Account',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                ),
                
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WishlistScreen(user: user1)),
                    );
                  },
                ),
              ],
            ),
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Email: $email',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 60,
              runSpacing: 15,
              children: [
                buildPreferenceBubble(pref1),
                buildPreferenceBubble(pref2),
                buildPreferenceBubble(pref3),
                buildPreferenceBubble(pref4),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality for editing account details
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BubblePage(), settings: RouteSettings(
                                    arguments: widget.user?.username,
                          ),
                        ),
                      );
              },
              child: const Text('Edit Preferences:',
              style: TextStyle(
                color:  Color.fromARGB(255, 241, 85, 137),
                // fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add functionality for logging out
                Navigator.popUntil(context, ModalRoute.withName('/login'));
              },
              child: const Text('Log Out',
              style: TextStyle(
                color:  Color.fromARGB(255, 241, 85, 137),
                // fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPreferenceBubble(String preference) {
    return GestureDetector(
      onTap: () {
        // Handle preference tap
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color:  Colors.white,
                          boxShadow: [
                            
                              BoxShadow(
                                color: const Color.fromARGB(255, 241, 85, 137).withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                          ],
                          border: Border.all(
                            color: const Color.fromARGB(255, 241, 85, 137),
                            width: 2.0,
                          ),
                        ),
        child: Text(
          preference,
          style: const TextStyle(
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
