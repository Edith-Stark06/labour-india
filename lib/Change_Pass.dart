import 'package:flutter/material.dart';
import 'package:ngo/Employee.dart';
import 'package:ngo/LoginScreen.dart';
import 'package:ngo/Labour_services.dart';

class Change_Pass extends StatefulWidget {
  @override
  _Change_PassState createState() => _Change_PassState();
}

class _Change_PassState extends State<Change_Pass> {


  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 10,),
                Container(
                  height: 140,
                  width: 170,
                  child: Image.asset('assets/images/laborindia.jpg'),
                ),
                const SizedBox(height: 30),
                Text(
                  "Change Password",
                  style: TextStyle(fontSize: 30, color: Colors.green[700]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                Text(
                  "NewPassword",
                  style: TextStyle(
                    fontSize: 24, // Increase font size
                    color: Colors.black, // Set text color to black
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                  textAlign: TextAlign.left,
                ),

                const SizedBox(height: 10),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "password",
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
                        color: Colors.green
                        , // Set the border color when focused
                        width: 1.0, // Set the border width when focused
                      ),
                    ),
                    fillColor: Colors.white.withOpacity(0.1),
                    filled: false,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Confirm Password",
                  style: TextStyle(
                    fontSize: 24, // Increase font size
                    color: Colors.black, // Set text color to black
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "password",
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
                        color: Colors.green
                        , // Set the border color when focused
                        width: 1.0, // Set the border width when focused
                      ),
                    ),
                    fillColor: Colors.white.withOpacity(0.1),
                    filled: false,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 10),

                SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.only(top: 2, left: 5),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Change",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      backgroundColor: Colors.green,
                    ),
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