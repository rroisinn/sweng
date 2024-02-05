import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:new_app/signup.dart';
import 'package:new_app/main.dart';
import 'package:new_app/database_helper.dart';

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
                  if (user != null && user.password == password) {
                    // Authentication successful
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Example()),
                    // );
                    Navigator.pushReplacementNamed(context, '/example');
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
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
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

//  
// LOGIN PAGE 2
// 
// 

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:new_app/signup.dart';
// import 'package:new_app/main.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({ Key? key }) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   int activeIndex = 0;

//   @override
//   void initState() {
//     Timer.periodic(Duration(seconds: 5), (timer) {
//       setState(() {
//         activeIndex++;

//         if (activeIndex == 4)
//           activeIndex = 0;
//       });
//     });
    
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               SizedBox(height: 50,),
//               Container(
//                 height: 350,
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       top: 0,
//                       left: 0,
//                       right: 0,
//                       bottom: 0,
//                       child: AnimatedOpacity(
//                         opacity: activeIndex == 0 ? 1 : 0, 
//                         duration: Duration(seconds: 1,),
//                         curve: Curves.linear,
//                         child: Image.network('https://ouch-cdn2.icons8.com/As6ct-Fovab32SIyMatjsqIaIjM9Jg1PblII8YAtBtQ/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNTg4/LzNmMDU5Mzc0LTky/OTQtNDk5MC1hZGY2/LTA2YTkyMDZhNWZl/NC5zdmc.png', height: 400,),
//                       ),
//                     ),
//                     Positioned(
//                       top: 0,
//                       left: 0,
//                       right: 0,
//                       bottom: 0,
//                       child: AnimatedOpacity(
//                         opacity: activeIndex == 1 ? 1 : 0, 
//                         duration: Duration(seconds: 1),
//                         curve: Curves.linear,
//                         child: Image.network('https://ouch-cdn2.icons8.com/vSx9H3yP2D4DgVoaFPbE4HVf6M4Phd-8uRjBZBnl83g/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNC84/MzcwMTY5OS1kYmU1/LTQ1ZmEtYmQ1Ny04/NTFmNTNjMTlkNTcu/c3Zn.png', height: 400,),
//                       ),
//                     ),
//                     Positioned(
//                       top: 0,
//                       left: 0,
//                       right: 0,
//                       bottom: 0,
//                       child: AnimatedOpacity(
//                         opacity: activeIndex == 2 ? 1 : 0, 
//                         duration: Duration(seconds: 1),
//                         curve: Curves.linear,
//                         child: Image.network('https://ouch-cdn2.icons8.com/fv7W4YUUpGVcNhmKcDGZp6pF1-IDEyCjSjtBB8-Kp_0/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMTUv/ZjUzYTU4NDAtNjBl/Yy00ZWRhLWE1YWIt/ZGM1MWJmYjBiYjI2/LnN2Zw.png', height: 400,),
//                       ),
//                     ),
//                     Positioned(
//                       top: 0,
//                       left: 0,
//                       right: 0,
//                       bottom: 0,
//                       child: AnimatedOpacity(
//                         opacity: activeIndex == 3 ? 1 : 0, 
//                         duration: Duration(seconds: 1),
//                         curve: Curves.linear,
//                         child: Image.network('https://ouch-cdn2.icons8.com/AVdOMf5ui4B7JJrNzYULVwT1z8NlGmlRYZTtg1F6z9E/rs:fit:784:767/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvOTY5/L2NlMTY1MWM5LTRl/ZjUtNGRmZi05MjQ3/LWYzNGQ1MzhiOTQ0/Mi5zdmc.png', height: 400,),
//                       ),
//                     )
//                   ]
//                 ),
//               ),
//               SizedBox(height: 40,),
//               TextField(
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(0.0),
//                   labelText: 'Email',
//                   hintText: 'Username or e-mail',
//                   labelStyle: TextStyle(
//                     color: Colors.black,
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   hintStyle: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 14.0,
//                   ),
//                   prefixIcon: Icon(Iconsax.user, color: Colors.black, size: 18, ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   floatingLabelStyle: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18.0,
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black, width: 1.5),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               TextField(
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(0.0),
//                   labelText: 'Password',
//                   hintText: 'Password',
//                   hintStyle: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 14.0,
//                   ),
//                   labelStyle: TextStyle(
//                     color: Colors.black,
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   prefixIcon: Icon(Iconsax.key, color: Colors.black, size: 18, ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   floatingLabelStyle: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18.0,
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black, width: 1.5),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () {}, 
//                     child: Text('Forgot Password?', style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),),
//                   )
//                 ],
//               ),
//               SizedBox(height: 30,),
//               MaterialButton(
//                 onPressed: (){Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Example()));
//                           },
//                 height: 45,
//                 color: Colors.black,
//                 child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 16.0),),
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//               SizedBox(height: 30,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Don\'t have an account?', style: TextStyle(color: Colors.grey.shade600, fontSize: 14.0, fontWeight: FontWeight.w400),),
//                   TextButton(
//                     onPressed: () {Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SignupPage()));
//                           }, 
//                     child: Text('Register', style: TextStyle(color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.w400),),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       )
//     );
//   }
// }

