class Job {
  final String companyName;
  final String jobTitle;
  final String description;
  final String location;
  final List<String> skills;
  final int daysOfWork;
  final String otherDetails;

  Job({
    required this.companyName,
    required this.jobTitle,
    required this.description,
    required this.location,
    required this.skills,
    required this.daysOfWork,
    required this.otherDetails,
  });
}
