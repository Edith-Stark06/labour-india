import 'package:flutter/material.dart';
import 'package:ngo/Employee.dart';
import 'package:ngo/LoginScreen.dart';
//import 'package:ngo/Services.dart';
import 'package:ngo/VerifyOtppage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Forgot_Pass extends StatefulWidget {
  Forgot_Pass({Key? key}) : super(key: key);

  @override
  _Forgot_PassState createState() => _Forgot_PassState();
}

class _Forgot_PassState extends State<Forgot_Pass> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Password Reset Email has been sent!',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'No user found for that email.',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 10,),
                  Container(
                    height: 140,
                    width: 170,
                    child: Image.asset('assets/images/laborindia.jpg'),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Forgot Password",
                    style: TextStyle(fontSize: 30, color: Colors.green[700]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Enter email",
                    style: TextStyle(
                      fontSize: 24, // Increase font size
                      color: Colors.black, // Set text color to black
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black, // Set the border color
                          width: 1.0, // Set the border width
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black, // Set the border color
                          width: 1.0, // Set the border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.green, // Set the border color when focused
                          width: 1.0, // Set the border width when focused
                        ),
                      ),
                      fillColor: Colors.white.withOpacity(0.1),
                      filled: false,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.only(top: 2, left: 5),
                    child: Builder(
                      builder: (context) => ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                            });
                            resetPassword(context);
                          }
                        },
                        child: const Text(
                          "Send Email",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
