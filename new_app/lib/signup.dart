import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:new_app/login.dart';
import 'package:new_app/database_helper.dart';
import 'package:new_app/preference.dart'; 

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =TextEditingController();

  // Initialize the database helper
  final DatabaseHelper databaseHelper = DatabaseHelper();

  String errorMessage = ''; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                          child: Center( // Center the image
                            child: Container(
                              height: 100, // Adjust the height as needed
                              width: 200, // Adjust the width as needed
                              child: Image.asset('assets/logo.png'),
                            ),
                          ), // Add this line
                      ),
                    
                  FadeInUp(duration: const Duration(milliseconds: 1000), child: const Text("Sign up", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),)),
                  const SizedBox(height: 10,),
                  FadeInUp(duration: const Duration(milliseconds: 1200), child: Text("Create an account, It's free", style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700]
                  ),)),
                ],
              ),
              Column(
                children: <Widget>[
                  FadeInUp(duration: const Duration(milliseconds: 1200), child: makeInput(label: "Email", controller: emailController)),
                  FadeInUp(duration: const Duration(milliseconds: 1300), child: makeInput(label: "Password", obscureText: true, controller: passwordController)),
                  FadeInUp(duration: const Duration(milliseconds: 1400), child: makeInput(label: "Confirm Password", obscureText: true, controller: confirmPasswordController)),
                ],
              ),
              FadeInUp(duration: const Duration(milliseconds: 1500), child: Container(
                padding: const EdgeInsets.only(top: 1, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: const Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  )
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {// Get user input
                      String email = emailController.text;
                      String password = passwordController.text;
                      String confirmPassword = confirmPasswordController.text;

                      // Validate email format
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern.toString());
                      if (!regex.hasMatch(email)) {
                        // Handle invalid email format
                        setState(() {
                          errorMessage = 'Please enter a valid email';
                        });
                        return;
                      }

                      // Validate input
                      if (password != confirmPassword) {
                        // Handle password mismatch
                        // Authentication failed
                        setState(() {
                        errorMessage = 'passwords do not match';
                    });
                        return;
                      }

                      // Validate password format
                      Pattern pattern2 =
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()-+]{8,}$';
                      RegExp regex2 = new RegExp(pattern2.toString());
                      if (!regex2.hasMatch(password)) {
                        // Handle invalid password format
                        setState(() {
                          errorMessage = 'Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one special character and one number';
                        });
                        return;
                      }
                      
                      

                      // Check if the user already exists
                      User? existingUser = await databaseHelper.getUser(email);
                      if (existingUser != null) {
                        // Handle existing user
                        setState(() {
                        errorMessage = 'user already exists';
                    });
                        return;
                      }

                      // Create a new user
                      User newUser = User(username: email, password: password);

                      // Insert the user into the database
                      await databaseHelper.insertUser(newUser);

                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BubblePage(), settings: RouteSettings(
                                    arguments: newUser.username,
                          ),
                        ),
                      );
                    },
                  color: const Color.fromARGB(255, 241, 85, 137),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Text("Sign up", style: TextStyle(
                    fontWeight: FontWeight.w600, 
                    fontSize: 18,
                    color: Colors.white
                  ),),
                ),
              )),
              FadeInUp(duration: const Duration(milliseconds: 1600), child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          }, 
                  child : const Text(" Login", style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 18
                  ),),
              )],
              )),
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
      ),
    );
  }

  Widget makeInput({label, obscureText = false, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),),
        const SizedBox(height: 5,),
        TextField(
          obscureText: obscureText,
          controller: controller, // Add this line to associate the controller
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
          ),
        ),
        const SizedBox(height: 30,),
      ],
    );
  }
}