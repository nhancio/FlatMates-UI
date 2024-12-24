import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/room_controller.dart';
import '../../../res/bottom/bottom_bar.dart';

class RoomDetailScreen extends StatelessWidget {
  final Room room;

  RoomDetailScreen({required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff8e6f1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Room Detail',
          style: TextStyle(
              color: Colors.purple, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room Type: ${room.roomType}',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text('Address: ${room.address}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Rent: ${room.roomRent}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Move-in Date: ${room.moveInDate}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Occupancy: ${room.occupationPerRoom}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Contact Number: ${room.mobileNumber}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Center(
              child:  ElevatedButton(
                onPressed: () async {
                  final Uri phoneUrl = Uri.parse('tel:${room.mobileNumber}');
                  try {
                    if (await canLaunchUrl(phoneUrl)) {
                      await launchUrl(phoneUrl);
                    } else {
                      throw 'Could not launch the dialer';
                    }
                  } catch (e) {
                    print('Error launching dialer: $e');
                  }
                },
                child: const Text('Call', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB60F6E),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
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
}

/*import 'package:flutter/material.dart';

import '../../../res/bottom/bottom_bar.dart';

class RoomDetailScreen extends StatelessWidget {
  final String roomName = 'Andrea';
  final String price = '\$2000';
  final String matchPercentage = '80%';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff8e6f1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBarScreen()),

            );
          },
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
                child: Text('Call',style: TextStyle(color: Colors.white),),
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
*/