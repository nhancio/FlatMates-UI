import 'package:flatemates_ui/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMateDetailsScreen extends StatelessWidget {
  final dynamic homemate;

  const HomeMateDetailsScreen({Key? key, required this.homemate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Go back to Home
        return false; // Prevent default back action (no dialog here)
      },
      child: Scaffold(
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
      ),
    );
  }

  Widget _buildProfileSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
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
                'Name: ${homemate.userName ?? 'Unknown'}',

                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Phone: ${homemate.userPhoneNumber ?? 'No Phone Number'}',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
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


