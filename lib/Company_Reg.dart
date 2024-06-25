import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngo/Company_services.dart';
import 'RegisterPage.dart';  // Ensure this import is correct
import 'package:cloud_firestore/cloud_firestore.dart';

class Company_Reg extends StatefulWidget {
  @override
  _Company_RegState createState() => _Company_RegState();
}

class _Company_RegState extends State<Company_Reg> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordsMatch = true;

  void checkPasswordMatch() {
    setState(() {
      passwordsMatch = passwordController.text == confirmPasswordController.text;
    });
  }

  Future<void> _registerUser() async {
    if (!passwordsMatch) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      String userId = userCredential.user!.uid;

      // Store user details in 'employer' document under 'roles' collection
      await _firestore.collection('roles').doc('employer').collection('employers').doc(userId).set({
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        // Add more fields as needed
      });

      Fluttertoast.showToast(msg: 'Registration Successful');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CompServices()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email');
      } else {
        showToast('Signup failed: ${e.message}');
      }
    } catch (e) {
      showToast('Signup failed: ${e.toString()}');
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 50),
                    Text(
                      "Registration",
                      style: TextStyle(fontSize: 30, color: Colors.green[700]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Company Name",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: "Company Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: false,
                        prefixIcon: Icon(Icons.account_circle),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                        ),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: false,
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                        ),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: false,
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      onChanged: (value) {
                        checkPasswordMatch();
                      },
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        errorText: passwordsMatch ? null : 'Passwords do not match',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                        ),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: false,
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    _registerUser();
                  },
                  child: Text(
                    "Register Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.green,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
