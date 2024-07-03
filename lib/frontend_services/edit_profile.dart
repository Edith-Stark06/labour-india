import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String username;
  final String email;
  final String? addressPermanent;
  final String? addressTemporary;
  final String? aadharNumber;
  final String? bankAccountNumber;
  final String? ifscCode;
  final String? bankName;

  EditProfilePage({
    required this.username,
    required this.email,
    this.addressPermanent,
    this.addressTemporary,
    this.aadharNumber,
    this.bankAccountNumber,
    this.ifscCode,
    this.bankName,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _addressPermanentController;
  late TextEditingController _addressTemporaryController;
  late TextEditingController _aadharNumberController;
  late TextEditingController _bankAccountNumberController;
  late TextEditingController _ifscCodeController;
  late TextEditingController _bankNameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _emailController = TextEditingController(text: widget.email);
    _addressPermanentController = TextEditingController(text: widget.addressPermanent ?? '');
    _addressTemporaryController = TextEditingController(text: widget.addressTemporary ?? '');
    _aadharNumberController = TextEditingController(text: widget.aadharNumber ?? '');
    _bankAccountNumberController = TextEditingController(text: widget.bankAccountNumber ?? '');
    _ifscCodeController = TextEditingController(text: widget.ifscCode ?? '');
    _bankNameController = TextEditingController(text: widget.bankName ?? '');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _addressPermanentController.dispose();
    _addressTemporaryController.dispose();
    _aadharNumberController.dispose();
    _bankAccountNumberController.dispose();
    _ifscCodeController.dispose();
    _bankNameController.dispose();
    super.dispose();
  }

  void saveProfile() {
    Map<String, String?> updatedProfile = {
      'username': _usernameController.text,
      'email': _emailController.text,
      'addressPermanent': _addressPermanentController.text.isNotEmpty ? _addressPermanentController.text : null,
      'addressTemporary': _addressTemporaryController.text.isNotEmpty ? _addressTemporaryController.text : null,
      'aadharNumber': _aadharNumberController.text.isNotEmpty ? _aadharNumberController.text : null,
      'bankAccountNumber': _bankAccountNumberController.text.isNotEmpty ? _bankAccountNumberController.text : null,
      'ifscCode': _ifscCodeController.text.isNotEmpty ? _ifscCodeController.text : null,
      'bankName': _bankNameController.text.isNotEmpty ? _bankNameController.text : null,
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
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _addressPermanentController,
              decoration: InputDecoration(labelText: 'Permanent Address'),
            ),
            TextField(
              controller: _addressTemporaryController,
              decoration: InputDecoration(labelText: 'Temporary Address'),
            ),
            TextField(
              controller: _aadharNumberController,
              decoration: InputDecoration(labelText: 'Aadhar Number'),
            ),
            TextField(
              controller: _bankAccountNumberController,
              decoration: InputDecoration(labelText: 'Bank Account Number'),
            ),
            TextField(
              controller: _ifscCodeController,
              decoration: InputDecoration(labelText: 'IFSC Code'),
            ),
            TextField(
              controller: _bankNameController,
              decoration: InputDecoration(labelText: 'Bank Name'),
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
