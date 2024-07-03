import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../frontend_services/employer/Comp_services.dart';
import '../frontend_services/employee/Labour_services.dart';
import '../frontend_services/LoginScreen.dart';
import 'FirestoreService.dart';

class login_check extends StatelessWidget {
  login_check({super.key});

  final firestoreService = FirestoreService();

  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userRole');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return const Center(child: Text("Access Denied"));
          } else if (snapshot.hasData) {
            final user = snapshot.data;
            print("User data: ${user?.email}");

            if (user != null) {
              return FutureBuilder<String?>(
                future: getUserRole(),
                builder: (context, userRoleSnapshot) {
                  if (userRoleSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (userRoleSnapshot.hasError) {
                    print("Error: ${userRoleSnapshot.error}");
                    return const Center(child: Text("Access Denied"));
                  } else {
                    final userRole = userRoleSnapshot.data;
                    if (userRole == 'employer') {
                      return CompServices();
                    } else if (userRole == 'employee') {
                      return Services();
                    } else {
                      print("No valid role found, navigating to SignInScreen");
                      return LoginScreen();
                    }
                  }
                },
              );
            } else {
              print("No user logged in, navigating to SignInScreen");
              return LoginScreen();
            }
          } else {
            print("No user logged in, navigating to SignInScreen");
            return LoginScreen();
          }
        },
      ),
    );
  }
}
