import 'package:flutter/material.dart';

import 'Change_Pass.dart';


class Verifyotppage extends StatefulWidget {
  @override
  _VerifyotppageState createState() => _VerifyotppageState();
}

class _VerifyotppageState extends State<Verifyotppage> {


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
                const SizedBox(height: 50),
                Text(
                  "OTP Verify",
                  style: TextStyle(fontSize: 30, color: Colors.green[700]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                const SizedBox(height: 30),
                Text(
                  "Enter your OTP",
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
                    hintText: "OTP",
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
                          builder: (context) => Change_Pass(),
                        ),
                      );
                    },
                    child: const Text(
                      "Verify",
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