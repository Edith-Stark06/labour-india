import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String username;
  final String email;
  final String? addressPermanent;
  final String? mobilenumber;

  EditProfilePage({
    required this.username,
    required this.email,
    this.addressPermanent,
    this.mobilenumber,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _addressPermanentController;
  late TextEditingController _mobileNumberController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _emailController = TextEditingController(text: widget.email);
    _addressPermanentController = TextEditingController(text: widget.addressPermanent ?? '');
    _mobileNumberController = TextEditingController(text: widget.mobilenumber ?? '');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _addressPermanentController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  void saveProfile() {
    Map<String, String?> updatedProfile = {
      'username': _usernameController.text,
      'email': _emailController.text,
      'addressPermanent': _addressPermanentController.text.isNotEmpty ? _addressPermanentController.text : null,
      'mobile number': _mobileNumberController.text.isNotEmpty ? _mobileNumberController.text : null,
    };

    Navigator.pop(context, updatedProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Username",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                fillColor: Colors.green.withOpacity(0.1),
                filled: false,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Email",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                fillColor: Colors.green.withOpacity(0.1),
                filled: false,
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Phone Number",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _mobileNumberController,
              decoration: InputDecoration(
                hintText: "Phone Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                fillColor: Colors.green.withOpacity(0.1),
                filled: false,
                prefixIcon: const Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Address",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _addressPermanentController,
              decoration: InputDecoration(
                hintText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                fillColor: Colors.green.withOpacity(0.1),
                filled: false,
                prefixIcon: const Icon(Icons.home),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: saveProfile,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
