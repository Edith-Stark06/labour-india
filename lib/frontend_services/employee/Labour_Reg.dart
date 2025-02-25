import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ngo/backend_services/login_check.dart';
import '../../backend_services/FirestoreService.dart';
import 'Labour_services.dart';
import '../RegisterPage.dart';  // Ensure this import is correct
import 'package:cloud_firestore/cloud_firestore.dart';


class employee_Reg extends StatefulWidget {
  @override
  _employee_RegState createState() => _employee_RegState();
}

class _employee_RegState extends State<employee_Reg> {

  final firestoreService = FirestoreService();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool passwordsMatch = true;

  void checkPasswordMatch() {
    setState(() {
      passwordsMatch = _passwordController.text == _confirmPasswordController.text;
    });
  }

  Future<void> _registerUser() async {
    if (!passwordsMatch) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      String userId = userCredential.user!.uid;
      bool success = await firestoreService.addUidToemployee(userId);


      // Store user details in 'employee' document under 'roles' collection
      await _firestore.collection('roles').doc('employee').collection('employees').doc(userId).set({
        'phone number': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        // Add more fields as needed
      });

      await _auth.signOut();

      Fluttertoast.showToast(msg: 'Registration Successful');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => login_check()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'The account already exists for that email');
      } else {
        Fluttertoast.showToast(msg: 'Registration failed: ${e.message}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Registration failed: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                      "phone number",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "phone number",
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
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
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
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
                      controller: _confirmPasswordController,
                      obscureText: true,
                      onChanged: (value) {
                        checkPasswordMatch();
                      },
                      decoration: InputDecoration(
                        hintText: "Confirm password",
                        errorText: passwordsMatch ? null : 'Passwords do not match',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
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
