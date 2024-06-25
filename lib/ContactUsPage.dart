import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF041701),
      body: SingleChildScrollView(
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
