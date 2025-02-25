import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ngo/frontend_services/FindJobs.dart';
import 'package:ngo/frontend_services/IndividualJob.dart';
import 'package:ngo/frontend_services/Job_posting.dart';
import 'package:ngo/frontend_services/ProfilePage.dart';
import 'package:ngo/frontend_services/SchemeDetailsPage.dart';
import 'package:ngo/frontend_services/employee/Labour_services.dart';
import 'package:ngo/frontend_services/employer/Comp_Services.dart';
import 'package:provider/provider.dart';
import 'frontend_services/UserState.dart';
import 'backend_services/login_check.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NGO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:login_check(),
    );
  }
}