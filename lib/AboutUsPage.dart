import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text('About Us'),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black),
    ),
    body: SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Image.asset('assets/images/Logo.png', height: 100),
    SizedBox(height: 10),
    Text(
    'About Us',
    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    SizedBox(height: 10),
    Text(
    'Empowering Fairness, One Payment at a Time',
    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 10),
    Image.asset('assets/images/peo.jpg', width: 134, height: 134),
    SizedBox(height: 10),
    Text(
    'At LabourIndia, we believe in a world where every worker is treated fairly and paid promptly for their hard work. Our mission is to revolutionize the daily wage payment system, eliminating middlemen and ensuring transparency in every transaction.',
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF766E6E)),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 20),
    Divider(height: 1, color: Color(0xFF766E6E)),
    SizedBox(height: 20),
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Image.asset('assets/images/people.jpg', width: 66, height: 80),
    SizedBox(width: 10),
    Expanded(
    child: Text(
    'Empower your team with clarity and trust in compensation management.',
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF766E6E)),
    textAlign: TextAlign.center,
    ),
    ),
    ],
    ),
    SizedBox(height: 10),
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Expanded(
    child: Text(
    'Gain insight into your worth, advocate for fair compensation, and plan for your future with confidence.',
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF766E6E)),
    textAlign: TextAlign.center,
    ),
    ),
    SizedBox(width: 10),
    Image.asset('assets/images/peo.jpg', width: 66, height: 66),
    ],
    ),
    SizedBox(height: 20),
    Divider(height: 1, color: Color(0xFF766E6E)),
    SizedBox(height: 20),
    Text(
    'Our Story',
    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    SizedBox(height: 10),
    Image.asset('assets/images/peo.jpg', width: 155, height: 118),
    SizedBox(height: 10),
    Text(
    'LabourIndia was founded by a group of passionate individuals who witnessed the challenges faced by workers in receiving fair wages. Fueled by the desire to create positive change, we set out to develop a solution that would empower workers and promote transparency in wage payments.',
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF766E6E)),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 20),
    Divider(height: 1, color: Color(0xFF766E6E)),
    SizedBox(height: 20),
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Image.asset('assets/images/peo.jpg', width: 62, height: 62),
    SizedBox(width: 10),
    Expanded(
    child: Text(
    'It was born from a need for streamlined compensation management, aiming to foster fairness and transparency between employers and employees.',
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF766E6E)),
    textAlign: TextAlign.center,
    ),
    ),
    ],
    ),
    SizedBox(height: 20),
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Expanded(
    child: Text(
    'Through user feedback and dedication, we evolve to meet the changing needs of businesses, ensuring they manage compensation with confidence and integrity.',
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF766E6E)),
    textAlign: TextAlign.start,
    ),
    ),
    SizedBox(width: 10),
    Image.asset('assets/images/peo.jpg', width: 62, height: 62),
    ],
    ),
    // Third section
    SizedBox(height: 20),
    Divider(height: 1, color: Color(0xFF766E6E)),
    SizedBox(height: 20),
    Text(
    'Contact',
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    SizedBox(height: 20),
    Text(
    'For business inquiries or other related issues, contact us and for  any queires contact',
    style: TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    ),
      textAlign: TextAlign.start,
    ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.phone, color: Colors.green),
          SizedBox(width: 5),
          Text(
            '+91 987 654 3210', // Update with your contact number
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF766E6E),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.email, color: Colors.green),
          SizedBox(width: 5),
          Text(
            'transparentwage@gmail.com', // Update with your email
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF766E6E),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.location_on, color: Colors.green),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plot 25, Sector 07, Ambattur Industrial Estate,', // Update with your address
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF766E6E),
                ),
              ),
              Text(
                'Ambattur, Chennai - 600110', // Update with your address
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF766E6E),
                ),
              ),
            ],
          ),
        ],
      ),
      SizedBox(height: 20),
      Text(
        'For business inquiries or other related issues, contact us:',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.start,
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.phone, color: Colors.green),
          SizedBox(width: 5),
          Text(
            '+91 987 654 3210', // Update with your contact number
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF766E6E),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.email, color: Colors.green),
          SizedBox(width: 5),
          Text(
            'transparentwage@gmail.com', // Update with your email
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF766E6E),
            ),
          ),
        ],
      ),
    ],
    ),
    ),
    ),
    );
  }
}
