import 'package:flutter/material.dart';
import 'job_model.dart';
import 'JobDetials.dart';

class ViewJobs extends StatelessWidget {
  final List<Job> jobs;

  const ViewJobs({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: Offset(0, 6),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/company${index + 1}bg.png",
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                job.companyName,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.star, size: 11),
                  Icon(Icons.star, size: 11),
                  Icon(Icons.star, size: 11),
                  Icon(Icons.star, size: 11),
                  Icon(Icons.star, size: 11),
                  SizedBox(width: 5),
                  Text(
                    "4.0/5",
                    style: TextStyle(fontSize: 10, color: Color(0xFF766E6E)),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.location_on, size: 10),
                  Text(
                    job.location,
                    style: TextStyle(fontSize: 10, color: Color(0xFF766E6E)),
                  ),
                  Text(" | ", style: TextStyle(fontSize: 10, color: Color(0xFF766E6E))),
                  Icon(Icons.calendar_today, size: 10),
                  Text(
                    "${job.daysOfWork} days",
                    style: TextStyle(fontSize: 10, color: Color(0xFF766E6E)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Skill required:",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF766E6E),
                ),
              ),
              Text(
                job.skills.join(', '),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF766E6E),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
