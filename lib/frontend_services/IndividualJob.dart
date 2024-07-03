import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Apply_success.dart';
import 'job_success.dart';

class IndividualJob extends StatefulWidget {
  final String companyUid;
  final String timestampKey;

  IndividualJob({required this.companyUid, required this.timestampKey});

  @override
  _IndividualJobState createState() => _IndividualJobState();
}

class _IndividualJobState extends State<IndividualJob> {
  Map<String, String>? jobDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJobDetails();
  }

  Future<void> fetchJobDetails() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('job_posts')
          .doc(widget.companyUid)
          .get();

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Map<String, dynamic> postedJobs = data['posted Jobs'] ?? {};
      Map<String, String> jobData = Map<String, String>.from(postedJobs[widget.timestampKey]);

      setState(() {
        jobDetails = jobData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load job details: $e')));
    }
  }

  Future<void> applyJob() async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference companyDoc = FirebaseFirestore.instance.collection('company_details').doc(widget.companyUid);
    DocumentReference userDoc = FirebaseFirestore.instance.collection('labour_details').doc(userUid);

    await companyDoc.set({
      'applied': {
        widget.timestampKey: FieldValue.arrayUnion([userDoc])
      }
    }, SetOptions(merge: true));

    await userDoc.set({
      'jobs applied': {
        widget.companyUid: FieldValue.arrayUnion([widget.timestampKey])
      }
    }, SetOptions(merge: true));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ApplySuccess()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Job Details'),
          backgroundColor: Colors.green,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('assets/images/company1bg.png', height: 200, width: double.infinity, fit: BoxFit.cover),
              SizedBox(height: 20),
              Text(
                jobDetails!['companyName']!,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Location: ${jobDetails!['location']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${jobDetails!['noOfDays']} days',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Skills Required: ${jobDetails!['skills']}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              if (jobDetails!.containsKey('jobDescription') && jobDetails!['jobDescription']!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Job Description:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      jobDetails!['jobDescription']!,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              if (jobDetails!.containsKey('otherDetails') && jobDetails!['otherDetails']!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Other Details:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      jobDetails!['otherDetails']!,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ElevatedButton(
                onPressed: applyJob,
                child: const Text(
                  "Apply Job",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
