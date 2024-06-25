import 'package:flutter/material.dart';
import 'job_model.dart';

class JobDetails extends StatelessWidget {
  final Job job;

  const JobDetails({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(job.jobTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Company: ${job.companyName}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Description: ${job.description}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Location: ${job.location}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Skills: ${job.skills.join(', ')}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Days of Work: ${job.daysOfWork}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Other Details: ${job.otherDetails}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
