import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'FindJobs.dart';
import 'IndividualJob.dart';

class CardPage extends StatefulWidget {
  CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<Map<String, String>> jobPostings = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchJobPostings();
  }

  Future<void> fetchJobPostings() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('job_posts').get();
      List<Map<String, String>> tempPostings = [];

      for (var doc in snapshot.docs) {
        String companyUid = doc.id;  // Get the UID of the company
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> postedJobs = data['posted Jobs'] ?? {};

        postedJobs.forEach((key, value) {
          Map<String, String> jobData = Map<String, String>.from(value);
          jobData['timestamp'] = key;
          jobData['companyUid'] = companyUid;  // Add the company UID to each job posting
          tempPostings.add(jobData);
        });
      }

      print(tempPostings.toString());

      setState(() {
        jobPostings = tempPostings;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> jobCards = jobPostings.map((job) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 5,
        child: Container(
          width: 344,
          height: 270,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/company1bg.png',height: 100,width: double.infinity,fit: BoxFit.cover,),
              SizedBox(height: 10),
              Text(
                job['companyName']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    job['location']!,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "${job['noOfDays']} days",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                "Skills: ${job['skills']}",
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndividualJob(
                          companyUid: job['companyUid']!,
                          timestampKey: job['timestamp']!,
                        ),
                      ),
                    );
                  },
                  child: Text("View Details"),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : FindJobs(jobCards: jobCards);
  }
}
