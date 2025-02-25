import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Apply_success.dart';

class IndividualJob extends StatefulWidget {
  final String companyUid;
  final String timestampKey;

  IndividualJob({required this.companyUid, required this.timestampKey});

  @override
  _IndividualJobState createState() => _IndividualJobState();
}

class _IndividualJobState extends State<IndividualJob> {
  Map<String, dynamic>? jobDetails;
  bool isLoading = true;
  bool hasApplied = false;
  int numberOfApplicants = 0;

  @override
  void initState() {
    super.initState();
    fetchJobDetails();
    checkIfApplied();
  }

  Future<void> fetchJobDetails() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('job_posts')
          .doc(widget.companyUid)
          .get();

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Map<String, dynamic> postedJobs = data['posted Jobs'] ?? {};
      Map<String, dynamic> jobData = Map<String, dynamic>.from(postedJobs[widget.timestampKey]);

      setState(() {
        jobDetails = jobData;
        numberOfApplicants = (jobData['applicants'] as List<dynamic>?)?.length ?? 0;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load job details: $e')));
    }
  }

  Future<void> checkIfApplied() async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('employee_details')
        .doc(userUid)
        .get();

    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    List<dynamic> jobsApplied = userData['jobsApplied']?[widget.companyUid] ?? [];

    setState(() {
      hasApplied = jobsApplied.contains(widget.timestampKey);
    });
  }

  Future<void> applyJob() async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    try {
      DocumentSnapshot userDocSnapshot =
      await FirebaseFirestore.instance.collection('employee_details').doc(userUid).get();

      if (!userDocSnapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incomple Profile -Fill your Profile Page Details to apply for job')));
        return;
      }

      Map<String, dynamic> userData = userDocSnapshot.data() as Map<String, dynamic>;
      String username = userData['username'] ?? '';
      String email = userData['email'] ?? '';
      String mobileNumber = userData['mobile number'] ?? '';

      DocumentReference companyDoc =
      FirebaseFirestore.instance.collection('company_details').doc(widget.companyUid);
      DocumentReference userDoc =
      FirebaseFirestore.instance.collection('employee_details').doc(userUid);
      DocumentReference jobDoc =
      FirebaseFirestore.instance.collection('job_posts').doc(widget.companyUid);

      String jobApplicationId = FirebaseFirestore.instance.collection('jobs').doc().id;
      DocumentReference jobApplicationDoc = FirebaseFirestore.instance
          .collection('jobs')
          .doc(widget.timestampKey)
          .collection('applicants')
          .doc(jobApplicationId);

      Map<String, dynamic> jobApplicationData = {
        'jobId': widget.timestampKey,
        'companyName': jobDetails!['companyName'] ?? '',
        'companyEmail': jobDetails!['companyEmail'] ?? '',
        'applicantId': userUid,
        'applicantName': username,
        'applicantMobile': mobileNumber,
      };

      WriteBatch batch = FirebaseFirestore.instance.batch();

      batch.set(companyDoc, {
        'applied': {
          widget.timestampKey: FieldValue.arrayUnion([jobApplicationId])
        }
      }, SetOptions(merge: true));

      batch.set(userDoc, {
        'jobsApplied': {
          widget.companyUid: FieldValue.arrayUnion([widget.timestampKey])
        }
      }, SetOptions(merge: true));

      batch.update(jobDoc, {
        'postedJobs.${widget.timestampKey}.applicants': FieldValue.arrayUnion([
          {
            'applicantId': userUid,
            'applicantName': username,
            'applicantEmail': email,
            'applicantMobile': mobileNumber,
          }
        ])
      });

      batch.set(jobApplicationDoc, jobApplicationData);

      await batch.commit();

      setState(() {
        hasApplied = true;
        numberOfApplicants++;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ApplySuccess()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error applying for job: $e')));
    }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Wages: ${jobDetails!['wages']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Employees: ${jobDetails!['noOfEmployees']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: hasApplied ? null : applyJob,
                child: Text(
                  hasApplied ? "Already Applied" : "Apply Job",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: hasApplied ? Colors.grey : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
