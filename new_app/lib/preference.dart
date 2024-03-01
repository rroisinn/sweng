import 'package:flutter/material.dart';
import 'package:new_app/database_helper.dart';
import 'package:new_app/main.dart';

class BubblePage extends StatefulWidget {
  const BubblePage({Key? key}) : super(key: key);

  @override
  State<BubblePage> createState() => _BubblePageState();
}

Future<void> initDatabase() async {
  await DatabaseHelper().initDatabase();
}

class _BubblePageState extends State<BubblePage> {
  final Set<String> _selectedIndices = {};
  String errorMessage = '';
  late String user;
  int max = 4;
  List<String> styles = [
    'Dress',
    'Skirt',
    'Jeans',
    'Jacket',
    'Bikini',
    'Maxi Dress',
    'Crop Top',
    'Jumper',
    'Trouser',
    'Blazer'
  ];

  @override
  Widget build(BuildContext context) {
    user = (ModalRoute.of(context)?.settings.arguments as String?) ?? 'error';
    debugPrint('User: $user');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
        // automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const Text(
            'Pick 4 styles you like!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: List.generate(
                    10,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_selectedIndices.contains(styles[index])) {
                            _selectedIndices.remove(styles[index]);
                            max += 1;
                          } else {
                            if (max > 0) {
                              _selectedIndices.add((styles[index]));
                              max -= 1;
                            } else {
                              debugPrint("Too many");
                            }
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: _selectedIndices.contains(styles[index]) ? const Color.fromARGB(255, 241, 85, 137) : Colors.white,
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
                          ' ${styles[index]} ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _selectedIndices.contains(styles[index]) ? Colors.white : const Color.fromARGB(255, 241, 85, 137),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              onPressed: () async {
                // Handle button press
                List<String> myList = _selectedIndices.toList();
                if (myList.length != 4) {
                  // If list size is not equal to 4, set error message
                  setState(() {
                    errorMessage = "Please pick 4 styles";
                  });
                  return;
                } else {
                  final DatabaseHelper databaseHelper = DatabaseHelper();
                  Preference pref = Preference(
                    username: user,
                    preference1: myList[0],
                    preference2: myList[1],
                    preference3: myList[2],
                    preference4: myList[3],
                  );
                  await databaseHelper.insertPref(pref);
                  User? user1 = await databaseHelper.getUser(user);
                  Navigator.pushNamed(
                    context,
                    Example.routeName,
                    arguments: user1,
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 241, 85, 137)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 60)),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (errorMessage.isNotEmpty)
            Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.purple,
                fontSize: 16,
              ),
            ),
          const SizedBox(height: 30),
          
        ],
      ),
    );
  }
}
