import 'package:flutter/material.dart';

class EditComp extends StatefulWidget {
  final String username;
  final String email;
  final String? addressPermanent;
  final String? description;

  EditComp({
    required this.username,
    required this.email,
    this.addressPermanent,
    this.description,
  });

  @override
  _EditCompState createState() => _EditCompState();
}

class _EditCompState extends State<EditComp> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _addressPermanentController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _emailController = TextEditingController(text: widget.email);
    _addressPermanentController = TextEditingController(text: widget.addressPermanent ?? '');
    _descriptionController = TextEditingController(text: widget.description ?? '');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _addressPermanentController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    Navigator.pop(context, {
      'username': _usernameController.text,
      'email': _emailController.text,
      'addressPermanent': _addressPermanentController.text,
      'description': _descriptionController.text,
    });
  }

  Future<bool> _onWillPop() async {
    _saveProfile();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _saveProfile,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                "Enter username",
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
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.start,
              ),
              TextField(
                controller: _emailController,
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
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.start,
              ),
              Container(
                width: double.infinity,
                height: 150.0,
                child: TextField(
                  controller: _addressPermanentController,
                  maxLines: 100,
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
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.start,
              ),
              Container(
                width: double.infinity,
                height: 150.0,
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 100,
                  decoration: InputDecoration(
                    hintText: "Description",
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
      ),
    );
  }
}
