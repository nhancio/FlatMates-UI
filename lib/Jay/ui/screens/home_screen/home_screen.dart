import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String firstScreen = "assets/images/first_page.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;
          return Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  firstScreen,
                  fit: BoxFit.cover,
                ),
              ),
              // Foreground Content with Gradient Overlay for better readability
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              // Main Content
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWideScreen ? 100.0 : 20.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Text(
                        'Hi Daniel',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Let's Find Peace For You!",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search location',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Cards Section
                      Text(
                        'Our Service',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildServiceCard(
                            'Looking for a RoomMate',
                            'assets/images/look_roommate.png',
                          ),
                          _buildServiceCard(
                            'Looking for a Room',
                            'assets/images/look_room.png',
                          ),
                          _buildServiceCard(
                            'Want to list my Room',
                            'assets/images/list_room.png',
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [

                            // _buildInfoCard(
                            //   'Rental Agreement',
                            //   'Tap Interested Options to Do a Rent Agreement for The Renter And Tenant.',
                            // ),
                            // SizedBox(width: 15), // Add spacing between cards
                            // _buildInfoCard(
                            //   'Tennant Verification',
                            //   'Fill an Online Or Offline Form to Get the Background Check of The Tenant And Landlord.',
                            // ),
                            // SizedBox(width: 15), // Add spacing between cards
                            // _buildInfoCard(
                            //   'Rental Receipt',
                            //   'Rent Receipts are Legal Proof of The Rent Being Paid With the Compliance of Income Tax Laws.',
                            // ),

                          ],
                        ),
                      ),

                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(String title, String imagePath) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: 80,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String description) {
    return Container(
      width: 200,
      height: 200,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Know More',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueAccent,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
