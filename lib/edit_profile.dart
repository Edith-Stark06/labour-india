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

  void _saveProfile() {
    Navigator.pop(context, {
      'username': _usernameController.text,
      'email': _emailController.text,
      'addressPermanent': _addressPermanentController.text,
      'addressTemporary': _addressTemporaryController.text,
      'aadharNumber': _aadharNumberController.text,
      'bankAccountNumber': _bankAccountNumberController.text,
      'ifscCode': _ifscCodeController.text,
      'bankName': _bankNameController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Enter username",
              style: TextStyle(
                fontSize: 20, // Increase font size
                color: Colors.black, // Set text color to black
                fontWeight: FontWeight.normal, // Make the text bold
              ),
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _usernameController, // Add this line
              decoration: InputDecoration(
                hintText: "Enter username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                fillColor: Colors.green.withOpacity(0.1),
                filled: false,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Email",
              style: TextStyle(
                fontSize: 20, // Increase font size
                color: Colors.black, // Set text color to black
                fontWeight: FontWeight.normal, // Make the text bold
              ),
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _emailController, // Add this line
              decoration: InputDecoration(
                hintText: "Enter Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                fillColor: Colors.green.withOpacity(0.1),
                filled: false,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Permanent Address",
              style: TextStyle(
                fontSize: 20, // Increase font size
                color: Colors.black, // Set text color to black
                fontWeight: FontWeight.normal, // Make the text bold
              ),
              textAlign: TextAlign.start,
            ),
            Container(
              width: double.infinity, // Make the text field take the full width of its parent
              height: 150.0, // Adjust the height as needed
              child: TextField(
                controller: _addressPermanentController,
                maxLines: 100, // Allows the text field to grow vertically
                decoration: InputDecoration(
                  hintText: "Enter Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  fillColor: Colors.green.withOpacity(0.1),
                  filled: false,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Temporary Address",
              style: TextStyle(
                fontSize: 20, // Increase font size
                color: Colors.black, // Set text color to black
                fontWeight: FontWeight.normal, // Make the text bold
              ),
              textAlign: TextAlign.start,
            ),
            Container(
              width: double.infinity, // Make the text field take the full width of its parent
              height: 150.0, // Adjust the height as needed
              child: TextField(
                controller: _addressTemporaryController,
                maxLines: 100, // Allows the text field to grow vertically
                decoration: InputDecoration(
                  hintText: "Enter Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  fillColor: Colors.green.withOpacity(0.1),
                  filled: false,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Aadhar card No",
              style: TextStyle(
                fontSize: 20, // Increase font size
                color: Colors.black, // Set text color to black
                fontWeight: FontWeight.normal, // Make the text bold
              ),
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _aadharNumberController, // Add this line
              decoration: InputDecoration(
                hintText: "Enter Aadhar no",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                fillColor: Colors.green.withOpacity(0.1),
                filled: false,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Bank Name",
              style: TextStyle(
                fontSize: 20, // Increase font size
                color: Colors.black, // Set text color to black
                fontWeight: FontWeight.normal, // Make the text bold
              ),
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _bankNameController, // Add this line
              decoration: InputDecoration(
                hintText: "Enter Bank name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                fillColor: Colors.green.withOpacity(0.1),
                filled: false,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Account no",
              style: TextStyle(
                fontSize: 20, // Increase font size
                color: Colors.black, // Set text color to black
                fontWeight: FontWeight.normal, // Make the text bold
              ),
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _bankAccountNumberController, // Add this line
              decoration: InputDecoration(
                hintText: "Enter Acc no",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                fillColor: Colors.green.withOpacity(0.1),
                filled: false,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Ifsc code",
              style: TextStyle(
                fontSize: 20, // Increase font size
                color: Colors.black, // Set text color to black
                fontWeight: FontWeight.normal, // Make the text bold
              ),
              textAlign: TextAlign.start,
            ),
            TextField(
              controller: _ifscCodeController, // Add this line
              decoration: InputDecoration(
                hintText: "Enter Ifsc",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                fillColor: Colors.green.withOpacity(0.1),
                filled: false,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
