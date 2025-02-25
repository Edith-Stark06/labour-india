import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ngo/frontend_services/employer/Comp_services.dart';
import '../edit_comp.dart';
// Import the ComServices page

class ComProfile extends StatefulWidget {
  @override
  _ComProfileState createState() => _ComProfileState();
}

class _ComProfileState extends State<ComProfile> {
  String username = '';
  String email = '';
  String? addressPermanent;
  String? description;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        email = user.email ?? '';
        username = user.displayName ?? '';
      });

      // Fetch additional data from Firestore if needed
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('company_details')
          .doc(user.uid)
          .get();

      if (userData.exists) {
        setState(() {
          addressPermanent = userData['addressPermanent'];
          description = userData['description'];
        });
      }
    }
  }

  void updateProfile(Map<String, String?> newProfileData) async {
    setState(() {
      username = newProfileData['username'] ?? username;
      email = newProfileData['email'] ?? email;
      addressPermanent = newProfileData['addressPermanent'] ?? addressPermanent;
      description = newProfileData['description'] ?? description;
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('company_details')
          .doc(user.uid)
          .set({
        'username': username,
        'email': email,
        'addressPermanent': addressPermanent,
        'description': description,
      });
    }
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => CompServices()), // Navigate to ComServices
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CompServices()), // Navigate to ComServices
              );
            },
          ),
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
                        TextSpan(
                            text: 'Permanent Address:\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: addressPermanent),
                      ],
                    ),
                  ),
                ),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(
                            text: 'Description:\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: description),
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
                      builder: (context) => EditComp(
                        username: username,
                        email: email,
                        addressPermanent: addressPermanent,
                        description: description,
                      ),
                    ),
                  );
                  if (newProfileData != null) {
                    updateProfile(Map<String, String?>.from(newProfileData));
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
