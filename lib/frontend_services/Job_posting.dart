import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'employer/Comp_services.dart';
import 'job_success.dart';

class JobPosting extends StatefulWidget {
  const JobPosting({super.key});

  @override
  State<JobPosting> createState() => _JobPostingState();
}

class _JobPostingState extends State<JobPosting> {
  // Controllers for the text fields
  final TextEditingController _companynameController = TextEditingController();
  final TextEditingController _LocationController = TextEditingController();
  final TextEditingController _SkillsController = TextEditingController();
  final TextEditingController _NoofdaysController = TextEditingController();
  final TextEditingController _JobdescritptionController = TextEditingController();
  final TextEditingController _otherDetailsController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _JobdescritptionController.dispose();
    _companynameController.dispose();
    _LocationController.dispose();
    _SkillsController.dispose();
    _NoofdaysController.dispose();
    _otherDetailsController.dispose();
    super.dispose();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late String uid;

  Future<void> post_job() async {
    uid = auth.currentUser!.uid;

    if (_companynameController.text.isEmpty ||
        _LocationController.text.isEmpty ||
        _SkillsController.text.isEmpty ||
        _NoofdaysController.text.isEmpty ||
        _JobdescritptionController.text.isEmpty ||
        _otherDetailsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    Map<String, String> newJob = {
      'companyName': _companynameController.text,
      'location': _LocationController.text,
      'skills': _SkillsController.text,
      'noOfDays': _NoofdaysController.text,
      'jobDescription': _JobdescritptionController.text,
      'otherDetails': _otherDetailsController.text,
    };

    String timestampKey = DateTime.now().toIso8601String();
    DocumentReference companyDoc = firestore.collection('company_details').doc(uid);
    DocumentReference postDoc = firestore.collection('job_posts').doc(uid);

    try {
      await postDoc.set({
        'posted Jobs': {timestampKey: newJob},
      }, SetOptions(merge: true));

      await companyDoc.set({
        'applied': {timestampKey: []},
      }, SetOptions(merge: true));

      _companynameController.clear();
      _LocationController.clear();
      _SkillsController.clear();
      _NoofdaysController.clear();
      _JobdescritptionController.clear();
      _otherDetailsController.clear();

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => JobSuccess()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to post job: $e')));
      }
      print('Error posting job: $e');
    }
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CompServices()), // Ensure CompServices is the correct previous page
    );
    return Future.value(false); // Prevent default back navigation
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1.0),
        appBar: AppBar(
          title: const Text("Post-Job"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CompServices()),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 50),
                    Text(
                      "Create Job",
                      style: TextStyle(fontSize: 30, color: Colors.green[700]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    TextField(
                      controller: _companynameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: false,
                        prefixIcon: const Icon(Icons.account_circle),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    TextField(
                      controller: _LocationController,
                      decoration: InputDecoration(
                        hintText: "Location",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                        ),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: false,
                        prefixIcon: const Icon(Icons.location_on),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Skills",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    TextField(
                      controller: _SkillsController,
                      decoration: InputDecoration(
                        hintText: "Skills required",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                        ),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: false,
                        prefixIcon: const Icon(Icons.sports_kabaddi),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "No of Days",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    TextField(
                      controller: _NoofdaysController,
                      decoration: InputDecoration(
                        hintText: "No. of days",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          ),
                        ),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: false,
                        prefixIcon: const Icon(Icons.today_sharp),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Job Description",
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
                        controller: _JobdescritptionController,
                        maxLines: 100,
                        decoration: InputDecoration(
                          hintText: "Job Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          fillColor: Colors.green.withOpacity(0.1),
                          filled: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Other Details",
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
                        controller: _otherDetailsController,
                        maxLines: 100,
                        decoration: InputDecoration(
                          hintText: "Other details",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          fillColor: Colors.green.withOpacity(0.1),
                          filled: false,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: post_job,
                        child: const Text("Post Job"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
