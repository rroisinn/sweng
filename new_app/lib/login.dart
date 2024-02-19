import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:new_app/signup.dart';
import 'package:new_app/main.dart';
import 'package:new_app/database_helper.dart';
import 'package:provider/provider.dart'; // Import Provider for state management

class LoginPage extends StatefulWidget {
  

  LoginPage({ Key? key }) : super(key: key);

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
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeInUp(
                          duration: Duration(milliseconds: 1200),
                          child: Text(
                            "Login to your account",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                            duration: Duration(milliseconds: 1200),
                            child: makeInput(label: "Email", controller: emailController)),
                        FadeInUp(
                            duration: Duration(milliseconds: 1300),
                            child: makeInput(
                                label: "Password", obscureText: true, controller: passwordController)),
                      ],
                    ),
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
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
                  print('Entered Email: $email'); // Add this line
                  print('Entered Password: $password'); // Add this line
                  // Validate user credentials
                  User? user = await databaseHelper.getUser(email);
                  print('User from database: $user');
                  print('Entered Password: $password');
                  print('User Password: ${user?.password}');
                  print('User id: ${user?.id}');
                  if (user != null && user.password == password) {
                    // Navigator.pushReplacementNamed(context, '/example');
                  //   Navigator.pushReplacementNamed(
                  //   context,
                  //   '/example',
                  //   arguments: user, // Pass the user as arguments
                  // );
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
                            color: Color.fromARGB(255, 241, 85, 137),
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
                      duration: Duration(milliseconds: 1500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account?"),
                          TextButton(
                    onPressed: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()));
                          }, 
                          child :Text(
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
                  style: TextStyle(
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
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          controller: controller, // Add this line to associate the controller
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}



