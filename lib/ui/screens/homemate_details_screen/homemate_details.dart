/*
import 'package:flutter/material.dart';

import '../../../res/bottom/bottom_bar.dart';

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
        iconTheme: IconThemeData(
          color:Color(0xFFB60F6E),
        ),
        backgroundColor: Color(0xfff8e6f1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFB60F6E)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBarScreen()),

            );
          },
        ),
        title: Text(
          'HomeMate Details',
          style: TextStyle(color: Color(0xFFB60F6E), fontSize: 22, fontWeight: FontWeight.bold),
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
               child:Stack(
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
*/


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMateDetailsScreen extends StatelessWidget {
  final dynamic homemate; // Replace `dynamic` with your homemate data type

  const HomeMateDetailsScreen({Key? key, required this.homemate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Color(0xFFB60F6E)
        ),
        backgroundColor: Color(0xfff8e6f1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFB60F6E)),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation,
                    secondaryAnimation) =>
                    HomemateList(userId: '',),
                transitionsBuilder: (context, animation,
                    secondaryAnimation, child) {
                  var tween = Tween(
                      begin: const Offset(0.0, 0.0),
                      end: Offset.zero)
                      .chain(
                      CurveTween(curve: Curves.ease));
                  var offsetAnimation =
                  animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
        ),
        title: const Text(
          'HomeMate Details',
          style: TextStyle(
            color: Color(0xFFB60F6E),

          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            const SizedBox(height: 20),
            _buildDetailRow('Gender', homemate.gender ?? 'Not specified'),
            _buildDetailRow('Age', homemate.age?.toString() ?? 'Not specified'),
            _buildDetailRow('Profession', homemate.profession ?? 'Not specified'),
            const SizedBox(height: 20),
            _buildSectionTitle('Preferences'),
            _buildPreferenceRow(homemate.preferences ?? []),
            const SizedBox(height: 20),
            _buildCallButton(homemate.userPhoneNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.purple, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(

                  "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              homemate.userName ?? 'Unknown',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              homemate.userPhoneNumber ?? 'No Phone Number',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceRow(List<dynamic> preferences) {
    final predefinedPreferences = {
      'Pet Lover': 'assets/icons/pet.png',
      'Gym Person': 'assets/icons/gym.png',
      'Travel Person': 'assets/icons/travel.png',
      'Party Person': 'assets/icons/party.png',
      'Music Person': 'assets/icons/music.png',
      'Vegan Person': 'assets/icons/vegan.png',
      'Sports Person': 'assets/icons/sport.png',
      'Yoga Person': 'assets/icons/yoga.png',
      'Non-Alcoholic': 'assets/icons/alcoholic.png',
      'Shopping Person': 'assets/icons/shopping.png',
      'Friendly Person': 'assets/icons/friends.png',
      'Studious': 'assets/icons/studious.png',
      'Growth': 'assets/icons/growth.png',
      'Non-Smoker': 'assets/icons/non_smoker.png',
    };

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: preferences.map((preference) {
        final iconPath = predefinedPreferences[preference] ?? 'assets/icons/default_icon.png';
        return Column(
          children: [
            Image.asset(iconPath, height: 60, width: 60),
            const SizedBox(height: 4),
            Text(
              preference,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCallButton(String? phoneNumber) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (phoneNumber != null && phoneNumber.isNotEmpty) {
            final Uri phoneUrl = Uri.parse('tel:$phoneNumber');
            launchUrl(phoneUrl);
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
    );
  }
}


