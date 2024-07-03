import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import for SystemNavigator.pop()
import 'package:shared_preferences/shared_preferences.dart';

import '../../backend_services/login_check.dart';
import '../AboutUsPage.dart';
import '../CardPage.dart';
import '../GovernmentSchemesPage.dart';
import '../ProfilePage.dart';
import '../RegisterPage.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  List<Map<String, String>> jobPostings = [];

  final List<String> imageTexts = [
    'Simplify Daily Wage\nManagement',
    'Transparent Wage\nPayment',
    'Easy Job Search and\nApply',
    'Apply to easy\nGovernment schemes'
  ];

  final List<String> headings = [
    'Heading Line 1 for Card 1\nHeading Line 2 for Card 1',
    'Heading Line 1 for Card 2\nHeading Line 2 for Card 2',
    'Heading Line 1 for Card 3\nHeading Line 2 for Card 3',
    'Heading Line 1 for Card 4\nHeading Line 2 for Card 4',
  ];

  final List<String> descriptions = [
    'This is a description text for Card 1 which can be up to 6-7 lines long. This should be smaller text size to fit the design properly.',
    'This is a description text for Card 2 which can be up to 6-7 lines long. This should be smaller text size to fit the design properly.',
    'This is a description text for Card 3 which can be up to 6-7 lines long. This should be smaller text size to fit the design properly.',
    'This is a description text for Card 4 which can be up to 6-7 lines long. This should be smaller text size to fit the design properly.',
  ];

  get selectedRole => RegisterPage();

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(), // Use SystemNavigator.pop() to exit the app
            child: Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Image.asset(
              'assets/images/laborindia.jpg',  // Replace with your image path
              height: 100.0,
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.contact_page),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_page),
                title: Text('Government Schemes'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GovernmentSchemesPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('View Jobs'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About Us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Logout'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => login_check()),
                  );
                },
              ),

            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Section 1: Carousel of Images with Overlay and Text
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: false,
                    enlargeCenterPage: true,
                  ),
                  items: [1, 2, 3, 4].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.asset(
                                'assets/images/cur$i.jpg',  // Replace with your image paths
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              color: Colors.green.withOpacity(0.5),
                            ),
                            Center(
                              child: Text(
                                imageTexts[i - 1],  // Use the corresponding text from the list
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              // Section 2: Carousel of Cards with CircleAvatar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: [1, 2, 3, 4].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Card(
                          elevation: 5.0,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: AssetImage('assets/images/cir$i.jpg'),  // Replace with your image paths
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  headings[i - 1],  // Use the heading for each card
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  descriptions[i - 1],  // Use the description for each card
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Learn More',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              // Third section
              Container(
                color: Color(0xFF041701),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      // Logo at the top center
                      Center(
                        child: Image.asset(
                          "assets/images/Logo.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Left and right parts with text
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildTextColumn(
                              "Employees",
                              [
                                "Salary info",
                                "Fairness",
                                "Trust",
                                "Future Plan"
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: _buildTextColumn(
                              "Employers",
                              [
                                "Salary",
                                "Transparency",
                                "Compliance",
                                "Communication"
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildTextColumn(
                              "Labours",
                              [
                                "Honesty",
                                "Transparency",
                                "Safety",
                                "Integrity"
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: _buildTextColumn(
                              "Security",
                              [
                                "Guidance",
                                "Safety",
                                "Enforcement",
                                "Training"
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Company logo and text at the bottom
                      SizedBox(height: 20),
                      Center(
                        child: Image.asset(
                          "assets/images/Logo.png",
                          width: 80,
                          height: 80,
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          "Company Name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        ...items.map(
              (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
