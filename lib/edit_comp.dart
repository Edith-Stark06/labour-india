import 'package:flutter/material.dart';

class edit_comp extends StatefulWidget {
  final String username;
  final String email;
  final String? addressPermanent;
  final String? discription;


  edit_comp({
    required this.username,
    required this.email,
    this.addressPermanent,
    this.discription,

  });

  @override
  _edit_compState createState() => _edit_compState();
}

class _edit_compState extends State<edit_comp> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _addressPermanentController;
  late TextEditingController _discriptionController;


  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _emailController = TextEditingController(text: widget.email);
    _addressPermanentController = TextEditingController(text: widget.addressPermanent ?? '');
    _discriptionController = TextEditingController(text: widget.discription ?? '');

  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _addressPermanentController.dispose();
    _discriptionController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    Navigator.pop(context, {
      'username': _usernameController.text,
      'email': _emailController.text,
      'addressPermanent': _addressPermanentController.text,
      'discription': _discriptionController.text,

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
              "Description",
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
                controller: _discriptionController,
                maxLines: 100, // Allows the text field to grow vertically
                decoration: InputDecoration(
                  hintText: "description",
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
