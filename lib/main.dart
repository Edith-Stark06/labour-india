import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngo/CardPage.dart';
import 'package:ngo/Change_Pass.dart';
import 'package:ngo/Company_Reg.dart';
import 'package:ngo/Company_services.dart';
import 'package:ngo/Forgot_Pass.dart';
import 'package:ngo/Job_posting.dart';
import 'package:ngo/Labour_Reg.dart';
import 'package:ngo/ProfilePage.dart';
import 'package:ngo/Labour_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ngo/Employee.dart';
import 'package:ngo/Employer.dart';
import 'package:ngo/FindJobsPage.dart';
import 'package:ngo/GovernmentSchemesPage.dart';
import 'package:ngo/RegisterPage.dart';
import 'package:ngo/AboutUsPage.dart';
import 'package:ngo/LoginScreen.dart';
import 'package:ngo/ContactUsPage.dart';
import 'package:ngo/ViewJobs.dart';
import 'package:ngo/job_success.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'JobDetials.dart';
import 'UserState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  void _checkAuthState() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      // Determine where to navigate based on user role or previous screen
      // For simplicity, assuming the last screen before logout determines next route
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? lastScreen = prefs.getString('lastScreen');

      if (lastScreen == '/services') {
        Navigator.of(context).pushReplacementNamed('/services');
      } else if (lastScreen == '/com_services') {
        Navigator.of(context).pushReplacementNamed('/com_services');
      } else {
        // Default fallback route (could be initial route or any other handling)
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/services': (context) => Services(),
        '/com_services': (context) => CompServices(),
        // Define other routes as necessary
      },
    );
  }
}