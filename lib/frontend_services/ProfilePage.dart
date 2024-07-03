import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile.dart';
import 'employee/Labour_services.dart'; // Replace with the actual import of your Services page

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String email = '';
  String? addressPermanent;
  String? addressTemporary;
  String? aadharNumber;
  String? bankAccountNumber;
  String? ifscCode;
  String? bankName;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('labour_details')
          .doc(user.uid)
          .get();

      if (userData.exists) {
        setState(() {
          email = user.email ?? '';
          username = userData['username'] ?? '';
          addressPermanent = userData['addressPermanent'];
          addressTemporary = userData['addressTemporary'];
          aadharNumber = userData['aadharNumber'];
          bankAccountNumber = userData['bankAccountNumber'];
          ifscCode = userData['ifscCode'];
          bankName = userData['bankName'];
        });
      }
    }
  }

  void updateProfile(Map<String, String?> newProfileData) async {
    setState(() {
      username = newProfileData['username'] ?? username;
      email = newProfileData['email'] ?? email;
      addressPermanent = newProfileData['addressPermanent'] ?? addressPermanent;
      addressTemporary = newProfileData['addressTemporary'] ?? addressTemporary;
      aadharNumber = newProfileData['aadharNumber'] ?? aadharNumber;
      bankAccountNumber = newProfileData['bankAccountNumber'] ?? bankAccountNumber;
      ifscCode = newProfileData['ifscCode'] ?? ifscCode;
      bankName = newProfileData['bankName'] ?? bankName;
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('labour_details').doc(user.uid).set({
        'username': username,
        'email': email,
        'addressPermanent': addressPermanent,
        'addressTemporary': addressTemporary,
        'aadharNumber': aadharNumber,
        'bankAccountNumber': bankAccountNumber,
        'ifscCode': ifscCode,
        'bankName': bankName,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Services()), // Replace with the actual route to ServicesPage
        );
        return false;
      },
      child: Scaffold(
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
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
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
      ),
    );
  }
}
