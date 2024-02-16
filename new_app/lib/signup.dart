import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:new_app/login.dart';
import 'package:new_app/database_helper.dart';

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
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Sign up", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),)),
                  SizedBox(height: 20,),
                  FadeInUp(duration: Duration(milliseconds: 1200), child: Text("Create an account, It's free", style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700]
                  ),)),
                ],
              ),
              Column(
                children: <Widget>[
                  FadeInUp(duration: Duration(milliseconds: 1200), child: makeInput(label: "Email", controller: emailController)),
                  FadeInUp(duration: Duration(milliseconds: 1300), child: makeInput(label: "Password", obscureText: true, controller: passwordController)),
                  FadeInUp(duration: Duration(milliseconds: 1400), child: makeInput(label: "Confirm Password", obscureText: true, controller: confirmPasswordController)),
                ],
              ),
              FadeInUp(duration: Duration(milliseconds: 1500), child: Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
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

                      // Validate input
                      if (password != confirmPassword) {
                        // Handle password mismatch
                        // Authentication failed
                        setState(() {
                        errorMessage = 'passwords do not match';
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

                      // Navigate to login page after successful registration},
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  color: Color.fromARGB(255, 241, 85, 137),
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
              FadeInUp(duration: Duration(milliseconds: 1600), child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }, 
                  child : Text(" Login", style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 18
                  ),),
              )],
              )),
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
      ),
    );
  }

  Widget makeInput({label, obscureText = false, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          obscureText: obscureText,
          controller: controller, // Add this line to associate the controller
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }
}