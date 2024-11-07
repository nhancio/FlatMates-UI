import 'package:flutter/material.dart';

class HomeMateDetailsScreen extends StatelessWidget {
  final String name = 'Daniel';
  final int age = 26;
  final String profession = 'Artist';
  final String matchPercentage = '80%';

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'HomeMate Details',
          style: TextStyle(color: Colors.purple, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.purple, width: 2),
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: screenWidth < 600
                        ? screenWidth * 0.6
                        : 300, // Adjust the height for mobile and web
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/daniel.png',
                        fit: BoxFit.contain, // Ensure the image is fully visible
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$name, $age',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          profession,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '$matchPercentage Matched',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    top: 16,
                    child: Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Basics Section
            _buildSectionTitle('Basics'),
            _buildInfoRow('Capricorn', Icons.cake),
            _buildInfoRow('Bachelors', Icons.school),
            _buildInfoRow('175 cm', Icons.height),

            // Interest Section
            _buildSectionTitle('Interest'),
            _buildChipRow(['Street Food', 'Live Music', 'Travel', 'Reading', 'Festivals']),

            // Lifestyle Section
            _buildSectionTitle('Lifestyle'),
            _buildChipRow(['Non-smoker', 'Cat', 'Vegan', 'On special occasions']),

            // Preferences Section
            _buildSectionTitle('Preference'),
            _buildPreferenceRow(),

            // Message Button
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle message action
                },
                child: Text('Message',style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB60F6E),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String info, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          SizedBox(width: 8),
          Text(
            info,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildChipRow(List<String> items) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items
          .map(
            (item) => Chip(
          label: Text(item),
          backgroundColor: Colors.grey[200],
        ),
      )
          .toList(),
    );
  }

  Widget _buildPreferenceRow() {
    List<Map<String, String>> preferences = [
      {'title': 'Non-Smoker', 'icon': 'assets/icons/non_smoker.png'},
      {'title': 'Travel Person', 'icon': 'assets/icons/travel.png'},
      {'title': 'Studious', 'icon': 'assets/icons/studious.png'},
      {'title': 'Yoga Person', 'icon': 'assets/icons/yoga.png'},
      {'title': 'Music Person', 'icon': 'assets/icons/music.png'},
      {'title': 'Non-Alcoholic', 'icon': 'assets/icons/alcoholic.png'},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: preferences.map((pref) {
        return Column(
          children: [
            Image.asset(
              pref['icon']!,
              height: 60,
              width: 60,
            ),
            SizedBox(height: 4),
            Text(
              pref['title']!,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        );
      }).toList(),
    );
  }
}
