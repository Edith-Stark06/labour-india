import 'package:flutter/material.dart';

class GovernmentSchemesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Section
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_two.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Easy access to",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Government Schemes",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1C9E07),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Image.asset(
                      'assets/images/four_frame_image.png',
                      width: 190,
                      height: 130,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Second Section
            Container(
              color: Color(0xFFC1F9BE),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 70,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "1920+",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Total Schemes",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFB0ACAC),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "967+",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "State Schemes",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFB0ACAC),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Third Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Find Schemes based on categories",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.count(
                        crossAxisCount: constraints.maxWidth < 600 ? 2 : 5,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: List.generate(10, (index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigate to another page on tap
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SchemeDetailsPage(
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/scheme${index + 1}.png",
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${index * 29 + 1} Schemes",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF1C9E07),
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  [
                                    "Agriculture, rural and environment",
                                    "Banking services and Insurance",
                                    "Business and Entrepreneurship",
                                    "Housing and Shelter",
                                    "Public Safety, Law & Justice",
                                    "Skills & Employment",
                                    "Transport & Infrastructure",
                                    "Social welfare & Empowerment",
                                    "Health & Wellness",
                                    "Utility & Sanitation"
                                  ][index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Fourth Section
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Find your best Scheme",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1599F9),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF1599F9),
                        size: 20,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Popular Schemes",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1C9E07),
                    ),
                  ),
                  Text(
                    "for you...",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(10),
                        width: 350,
                        height: 85,
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
                        child: Row(
                          children: [
                            Image.asset(
                              [
                                "assets/images/pmmy_logo.png",
                                "assets/images/pmay_logo.png",
                                "assets/images/aay_logo.png",
                                "assets/images/ab_logo.png",
                                "assets/images/pmkvy_logo.png",
                                "assets/images/hi_logo.png"
                              ][index],
                              width: 54,
                              height: 54,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                [
                                  "Pradhan Mantri Mudra Yojana",
                                  "Pradhan Mantri Awas Yojana",
                                  "Antyodaya Anna Yojana",
                                  "Ayushman Bharat",
                                  "Pradhan Mantri Kaushal Vikas Yojana",
                                  "Health Insurance"
                                ][index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF766E6E),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SchemeDetailsPage extends StatelessWidget {
  final int index;

  SchemeDetailsPage({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheme Details'),
      ),
      body: Center(
        child: Text('Details for scheme ${index + 1}'),
      ),
    );
  }
}
