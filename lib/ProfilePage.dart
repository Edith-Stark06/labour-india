import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfilePage extends StatefulWidget {


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = ''; // Remove default username
  String email = ''; // Remove default email
  String? addressPermanent;
  String? addressTemporary;
  String? aadharNumber;
  String? bankAccountNumber;
  String? ifscCode;
  String? bankName;


  void initState() {
    super.initState();
    getUserData(); // Fetch user data when the widget is initialized
  }

  Future<void> getUserData() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // If user is not null, get their email and username
      setState(() {
        email = user.email ?? ''; // Set email to user's email if available
        username = user.displayName ?? ''; // Set username to user's display name if available
      });
    }
  }


  void updateProfile(Map<String, String?> newProfileData) async {
    setState(() {
      // Update username and email if changed
      username = newProfileData['username'] ?? username;
      email = newProfileData['email'] ?? email;

      // Update additional details
      addressPermanent = newProfileData['addressPermanent'] ?? addressPermanent;
      addressTemporary = newProfileData['addressTemporary'] ?? addressTemporary;
      aadharNumber = newProfileData['aadharNumber'] ?? aadharNumber;
      bankAccountNumber = newProfileData['bankAccountNumber'] ?? bankAccountNumber;
      ifscCode = newProfileData['ifscCode'] ?? ifscCode;
      bankName = newProfileData['bankName'] ?? bankName;
    });

    // Update Firestore with the new data
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('labour_details').doc(user.uid).update({
        'username': username,
        'email': email,
        'addressPermanent': addressPermanent,
        'addressTemporary': addressTemporary,
        'aadharNumber': aadharNumber,
        'bankAccountNumber': bankAccountNumber,
        'ifscCode': ifscCode,
        'bankName': bankName,
        // Add more fields as needed
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Registration",
              style: TextStyle(fontSize: 30, color: Colors.green[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 20),
            Text(username, style: TextStyle(fontSize: 20)),
            Text(email, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            if (addressPermanent != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(text: 'Permanent Address:\n', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: addressPermanent),
                    ],
                  ),
                ),
              ),
            if (addressTemporary != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(text: 'Temporary Address:\n', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: addressTemporary),
                    ],
                  ),
                ),
              ),
            if (aadharNumber != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(text: 'Aadhar Number: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: aadharNumber),
                    ],
                  ),
                ),
              ),
            if (bankAccountNumber != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(text: 'Bank Account Number: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: bankAccountNumber),
                    ],
                  ),
                ),
              ),
            if (ifscCode != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(text: 'IFSC Code: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ifscCode),
                    ],
                  ),
                ),
              ),
            if (bankName != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(text: 'Bank Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: bankName),
                    ],
                  ),
                ),
              ),
            //SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Set the background color to green
              ),
              onPressed: () async {
                final newProfileData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      username: username,
                      email: email,
                      addressPermanent: addressPermanent,
                      addressTemporary: addressTemporary,
                      aadharNumber: aadharNumber,
                      bankAccountNumber: bankAccountNumber,
                      ifscCode: ifscCode,
                      bankName: bankName,
                    ),
                  ),
                );
                if (newProfileData != null) {
                  updateProfile(newProfileData);
                }
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

