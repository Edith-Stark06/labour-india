import 'package:flutter/material.dart';


class FindJobs extends StatelessWidget {
  final List<Widget> jobCards;

  const FindJobs({super.key, required this.jobCards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Jobs"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: jobCards,
      ),
    );
  }
}

