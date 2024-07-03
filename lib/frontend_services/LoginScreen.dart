import 'package:flutter/material.dart';
import 'package:ngo/frontend_services/auth/Employee.dart';

import 'auth/Employer.dart';
import 'RegisterPage.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color of the entire screen to black
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0), // Adjust padding for better spacing
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    // Handle close action
                  },
                ),
              ),
              SizedBox(height: 0),
              Image.asset(
                'assets/images/Logo.png',
                height: screenSize.height * 0.2, // Adjust image height based on screen size
              ),
              SizedBox(height: 10),
              Text(
                'Login as',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenSize.width * 0.08, // Adjust font size based on screen size
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30),
              LoginButton(
                text: 'Employer',
                iconPath: 'assets/images/peo.jpg',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Employer(),
                    ),
                  );
                },
              ),
              SizedBox(height: 40),
              LoginButton(
                text: 'Employee',
                iconPath: 'assets/images/peo.jpg',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Employee(),
                    ),
                  );
                },
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign up',
                      style: TextStyle(
                        color: Color(0xFF4DB2FB),
                        fontSize: screenSize.width * 0.06, // Adjust font size based on screen size
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward, // Use the forward arrow icon
                      color: Color(0xFF4DB2FB),
                      size: screenSize.width * 0.06, // Adjust icon size based on screen size
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;

  LoginButton({
    required this.text,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: screenSize.width * 0.7, // Adjust width based on screen size
      height: screenSize.height * 0.08, // Adjust height based on screen size
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(
          iconPath,
          height: screenSize.height * 0.04, // Adjust icon height based on screen size
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: screenSize.width * 0.07, // Adjust font size based on screen size
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xB329B712), // 70% opacity green
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
