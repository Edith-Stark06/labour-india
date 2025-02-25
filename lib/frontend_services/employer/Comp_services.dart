import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ngo/backend_services/login_check.dart';

import '../AboutUsPage.dart';
import '../Change_Pass.dart';
import 'Com_profile.dart';
import '../GovernmentSchemesPage.dart';
import '../Job_posting.dart';
import '../employee/Labour_Reg.dart';
import '../RegisterPage.dart';

class CompServices extends StatelessWidget {
  // Lists for headings and descriptions
  final List<String> imageTexts = [
    'Simplify Daily Wage\nManagement',
    'Transperent Wage\nPayment',
    'Easy Job Search and\nApply',
    'Apply to easy\nGovernment schemes'
  ];
  final List<String> headings = [
    'Promote Transparency ',
    'Ensure Compliance',
    'Facilitate Communication',
    'Easy Job Apply',
  ];

  final List<String> descriptions = [
    'Ensure clear and open communication in all processes to build trust and foster accountability, Make information accessible .',
    ' Adhere to industry regulations and internal policies to maintain legal standards and operational integrity, Regular audits .',
    ' Encourage seamless information exchange by implementing reliable communication channels and tools,Foster an environment .',
    'Simplify the application process with user-friendly interfaces and clear instructions. Enable quick and efficient job applications .',
  ];
  get selectedRole => RegisterPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/images/Logo.png',  // Replace with your image path
            height: 100.0,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
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
              leading: const Icon(Icons.contact_page),
              title: const Text('comp_Profile'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ComProfile()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_page),
              title: const Text('Post jobs'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const JobPosting()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutUsPage()),
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
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              'assets/images/cur$i.jpg',  // Replace with your image paths
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            color: Colors.green.withOpacity(0.5),
                          ),
                          Center(
                            child: Text(
                              imageTexts[i - 1],  // Use the corresponding text from the list
                              textAlign: TextAlign.center,
                              style: const TextStyle(
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
                  height: 350.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: [1, 2, 3, 4].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        elevation: 5.0,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: AssetImage('assets/images/cir$i.jpg'),  // Replace with your image paths
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                headings[i - 1],  // Use the heading for each card
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                descriptions[i - 1],  // Use the description for each card
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              TextButton(
                                onPressed: () {},
                                child: const Row(
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
            //third section
            Container(
              color: const Color(0xFF041701),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Logo at the top center
                    Center(
                      child: Image.asset(
                        "assets/images/Logo.png",
                        width: 100,
                        height: 100,
                      ),
                    ),
                    // Features sectio
                    // Description
                    const Text(
                      "Get end-to-end visibility of your employees with top-notch staff management and payment software for your use",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Social media handles
                    // Contact details
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Contact Us",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildContactDetailRow(Icons.phone, "+91 8926726726"),
                          const SizedBox(height: 10),
                          _buildContactDetailRow(Icons.mail, "nasctelangana@gmail.com "),
                          const SizedBox(height: 5),
                          _buildContactDetailRow(Icons.location_on, "12-13-479, Street No: 1, Tarnaka, Hyderabad-500017"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Divider line
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 0.5,
                      color: const Color(0xFF766E6E),
                    ),
                    const SizedBox(height: 10),
                    // Copy right text
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 13,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "2024 by ALTRUISTY. All rights reserved",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
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
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        for (String subHeading in subHeadings)
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text(
              subHeading,
              style: const TextStyle(
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Icon(
            icon,
            size: 13,
            color: Colors.white,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF766E6E),
            ),
          ),
        ],
      ),
    );
  }
}
