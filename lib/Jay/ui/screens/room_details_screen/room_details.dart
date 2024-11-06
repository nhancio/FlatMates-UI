import 'package:flutter/material.dart';

class RoomDetailScreen extends StatelessWidget {
  final String roomName = 'Andrea';
  final String price = '\$2000';
  final String matchPercentage = '80%';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Room Detail',
          style: TextStyle(color: Colors.purple, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card with AspectRatio for better scaling
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.purple, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9, // Maintain a 16:9 aspect ratio for the image
                  child: Image.asset(
                    'assets/images/room.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Room Details
            Text(
              roomName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
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

            // Basics Section
            _buildSectionTitle('Basics'),
            _buildInfoRow('Age', Icons.cake),
            _buildInfoRow('Bachelors', Icons.school),
            _buildInfoRow('175 cm', Icons.height),

            // Amenities Section
            _buildSectionTitle('Amenities'),
            _buildChipRow(['Fridge', 'Kitchen', 'WiFi', 'Reading']),

            // Lifestyle Section
            _buildSectionTitle('Lifestyle'),
            _buildChipRow(['Non-smoker', 'Cat', 'Vegan', 'On special occasions']),

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
}
