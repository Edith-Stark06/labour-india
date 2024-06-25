import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Forgot_Pass.dart';
import 'RegisterPage.dart';
import 'Labour_services.dart';

class Employee extends StatefulWidget {
  @override
  _EmployeeState createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> signInWithEmailAndPassword() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showToast('Please enter both email and password');
      return;
    }

    try {
      // Sign in with Firebase Authentication using the provided email and password
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Check if the user is an employee
      String userId = userCredential.user!.uid;
      bool isEmployee = await checkIfEmployee(userId);

      if (isEmployee) {
        showToast('Login successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Services()),
        );
      } else {
        showToast('You are not a valid user');
        await FirebaseAuth.instance.signOut(); // Sign out if not a valid user
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Invalid email or password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        showToast('An error occurred: ${e.message}');
      }
    } catch (e) {
      showToast('Login failed: $e');
    }
  }

  Future<bool> checkIfEmployee(String userId) async {
    try {
      DocumentSnapshot employeeSnapshot = await FirebaseFirestore.instance
          .collection('roles')
          .doc('employee')
          .collection('employees')
          .doc(userId)
          .get();

      return employeeSnapshot.exists;
    } catch (e) {
      print('Error checking employee status: $e');
      return false;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                  height: 150,
                  width: 180,
                  child: Image.asset('assets/images/laborindia.jpg'),
                ),
                Container(
                  height: 120,
                  width: 150,
                  child: Image.asset('assets/images/peo.jpg'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Labour",
                  style: TextStyle(fontSize: 30, color: Colors.green[700]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1.0,
                      ),
                    ),
                    fillColor: Colors.white.withOpacity(0.1),
                    filled: false,
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1.0,
                      ),
                    ),
                    fillColor: Colors.white.withOpacity(0.1),
                    filled: false,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Forgot_Pass(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(top: 2, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: signInWithEmailAndPassword,
                        child: const Text(
                          "Log In",
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
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "New user?",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterPage()),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
