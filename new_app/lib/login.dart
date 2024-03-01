import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:new_app/signup.dart';
import 'package:new_app/main.dart';
import 'package:new_app/database_helper.dart';
 // Import Provider for state management

class LoginPage extends StatefulWidget {
  

  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // Initialize the database helper
  final DatabaseHelper databaseHelper = DatabaseHelper();

  String errorMessage = ''; 
 // New variable to store error message
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                          child: Center( // Center the image
                            child: Container(
                              height: 100, // Adjust the height as needed
                              width: 200, // Adjust the width as needed
                              child: Image.asset('assets/logo.png'),
                            ),
                          ), // Add this line
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          child: Text(
                            "Login to your account",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                            duration: const Duration(milliseconds: 1200),
                            child: makeInput(label: "Email", controller: emailController)),
                        FadeInUp(
                            duration: const Duration(milliseconds: 1300),
                            child: makeInput(
                                label: "Password", obscureText: true, controller: passwordController)),
                      ],
                    ),
                  ),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1400),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: const Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                  // Get user input
                  String email = emailController.text;
                  String password = passwordController.text;
                  debugPrint('Entered Email: $email'); // Add this line
                  print('Entered Password: $password'); // Add this line
                  // Validate user credentials
                  User? user = await databaseHelper.getUser(email);
                  debugPrint('User from database: $user');
                  debugPrint('Entered Password: $password');
                  debugPrint('User Password: ${user?.password}');
                  debugPrint('User id: ${user?.id}');
                  if (user != null && user.password == password) {
                   
                  debugPrint('User: $user');
                  Navigator.pushNamed(
                    context,
                    Example.routeName,
                    arguments: user,
                  );
                  } else {
                    // Authentication failed
                    setState(() {
                    errorMessage = 'Incorrect username or password';
                    });
                    // Handle incorrect username or password
                    
                          // Update the UI to show the error message
                          // setState(() {});
                  }
                          },
                            color: const Color.fromARGB(255, 241, 85, 137),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                   fontSize: 18,
                                   color: Colors.white
                                   ),
                            ),
                          ),
                        ),
                      )),
                  FadeInUp(
                      duration: const Duration(milliseconds: 1500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Don't have an account?"),
                          TextButton(
                    onPressed: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          }, 
                          child :const Text(
                            "Sign up",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                      )],
                      )),
                      // Display error message if there's any
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                ],
                
              ),
            ),
            // FadeInUp(
            //     duration: Duration(milliseconds: 1200),
            //     child: Container(
            //       height: MediaQuery.of(context).size.height / 3,
            //       decoration: BoxDecoration(
            //           image: DecorationImage(
            //               image: AssetImage('/illustration.png'),
            //               fit: BoxFit.cover)),
            //     ))
          ],
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          controller: controller, // Add this line to associate the controller
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}



