import 'package:flutter/material.dart';


class SchemeDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/3_image.png',
              height: 50,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/0_image.png'),
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    // Logout action
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
        toolbarHeight: 53,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section 2: Image with Text
            Stack(
              children: [
                Image.asset(
                  'assets/images/cur1.jpg',
                  width: 393,
                  height: 219,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      'Middfkldflt',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Section 3: Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Search action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(12),
                    ),
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),

            // Section 4: Scheme Buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Show all schemes
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(137, 30),
                    ),
                    child: Text('All Schemes'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Show state schemes
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(137, 30),
                    ),
                    child: Text('State Schemes'),
                  ),
                ],
              ),
            ),

            // Section 5: Scheme Cards
            ...List.generate(5, (index) => jobCard()), // Generate 5 example cards
          ],
        ),
      ),
    );
  }
}

class jobCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 362,
        height: 367,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tamil Nadu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Scheme Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Description about the scheme in 3-4 lines...',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                Chip(
                  label: Text('Farmer'),
                  backgroundColor: Colors.grey[200],
                ),
                Chip(
                  label: Text('Financial Assistance'),
                  backgroundColor: Colors.grey[200],
                ),
                Chip(
                  label: Text('Labour'),
                  backgroundColor: Colors.grey[200],
                ),
                Chip(
                  label: Text('Pension'),
                  backgroundColor: Colors.grey[200],
                ),
              ],
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                // Learn more action
              },
              style: TextButton.styleFrom(
                side: BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Learn More'),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
