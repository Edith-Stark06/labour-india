import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:ngo/AboutUsPage.dart';
import 'package:ngo/Change_Pass.dart';
import 'package:ngo/Com_profile.dart';
import 'package:ngo/Company_Reg.dart';
import 'package:ngo/Forgot_Pass.dart';
import 'package:ngo/GovernmentSchemesPage.dart';
import 'package:ngo/Job_posting.dart';
import 'package:ngo/Labour_Reg.dart';
import 'package:ngo/ProfilePage.dart';
import 'package:ngo/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompServices extends StatefulWidget {
  @override
  _CompServicesState createState() => _CompServicesState();
}

class _CompServicesState extends State<CompServices> {
  List<Map<String, String>> jobPostings = [];

  void _updateJobPostings(List<Map<String, String>> updatedJobPostings) {
    setState(() {
      jobPostings = updatedJobPostings;
    });
  }

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
          title: Text('profile'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ComProfile()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('post job'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => JobPosting()),
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
          leading: Icon(Icons.info),
          title: Text('Logout'),
          onTap: () async {
            // Save the last visited screen before logging out
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (ModalRoute.of(context)?.settings.name != null) {
              prefs.setString('lastScreen', ModalRoute.of(context)!.settings.name!);
            }
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed('/login');
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
      // Section 3: Footer Section
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
      "Company",
      [
      "About Us",
      "Services",
      "Contact Us",
      "Help",
        "Support"
      ],
      ),
      ),
        SizedBox(width: 20),
        Expanded(
          child: _buildTextColumn(
            "Legal",
            [
              "Terms & Conditions",
              "Privacy Policy",
              "Refund/Cancellation"
            ],
          ),
        ),
      ],
      ),
        SizedBox(height: 10),
        // Features section
        _buildTextColumn(
          "Features",
          [
            "Salary Management",
            "Transparency Tools",
            "Compliance Tracking",
            "Communication Hub",
            "Security Measures"
          ],
          isCentered: true,
        ),
        SizedBox(height: 20),
        // Divider line
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 0.5,
          color: Color(0xFF766E6E),
        ),
        SizedBox(height: 20),
        // Logo
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            "assets/images/Logo.png",
            width: 80,
            height: 70,
          ),
        ),
        SizedBox(height: 20),
        // Description
        Text(
          "Get end-to-end visibility of your employees with top-notch staff management and payment software for your use",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        // Social media handles
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialMediaIcon("assets/images/facebook_logo.png"),
            SizedBox(width: 10),
            _buildSocialMediaIcon("assets/images/insta_logo.png"),
            SizedBox(width: 10),
            _buildSocialMediaIcon("assets/images/linkedin_logo.png"),
            SizedBox(width: 10),
            _buildSocialMediaIcon("assets/images/youtube_logo.png"),
          ],
        ),
        SizedBox(height: 20),
        // App store logos
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/apple_appstore.png",
              width: 145,
              height: 45,
            ),
            SizedBox(width: 10),
            Image.asset(
              "assets/images/google_playstore.png",
              width: 145,
              height: 45,
            ),
          ],
        ),
        SizedBox(height: 20),
        // Contact details
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact Us",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              _buildContactDetailRow(Icons.phone, "+91 987 654 3210"),
              SizedBox(height: 10),
              _buildContactDetailRow(Icons.mail, "transparentwage@gmail.com"),
              SizedBox(height: 5),
              _buildContactDetailRow(Icons.location_on, "Plot 25, Sector 07, Ambattur Industrial Estate, Ambattur, Chennai - 600110"),
            ],
          ),
        ),
        SizedBox(height: 20),
        // Divider line
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 0.5,
          color: Color(0xFF766E6E),
        ),
        SizedBox(height: 10),
        // Copy right text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 13,
              color: Colors.white,
            ),
            SizedBox(width: 5),
            Text(
              "2024 by Varshini Technology Private Limited. All rights reserved",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
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

  Widget _buildTextColumn(String heading, List<String> subHeadings, {bool isCentered = false}) {
    return Column(
      crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        for (String subHeading in subHeadings)
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text(
              subHeading,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color(0xFF766E6E),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSocialMediaIcon(String imagePath) {
    return Image.asset(
      imagePath,
      width: 25,
      height: 25,
    );
  }

  Widget _buildContactDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 13,
          color: Colors.white,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF766E6E),
          ),
        ),
      ],
    );
  }
}
