/*
import 'package:flatmates/screen/chat_screen/chat_screen.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlateMateDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check if arguments are passed, otherwise provide a default value
    final String location = Get.arguments != null && Get.arguments.containsKey('location')
        ? Get.arguments['location']
        : '';

    final List<Map<String, String>> flatmates = Get.arguments != null && Get.arguments.containsKey('flatmates')
        ? Get.arguments['flatmates']
        : [];

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Flatmate Details in $location',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        'assets/images/daniel.png',
                        height: 200,  // Adjusted height to match the first screenshot
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '80% Matched',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              'D',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Daniel, 26',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Artist',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SectionTitle(title: 'Basics'),
              Wrap(
                spacing: 8.0,
                children: [
                  ProfileChip(icon: Icons.star, label: 'Capricorn', isDarkMode: isDarkMode),
                  ProfileChip(icon: Icons.school, label: 'Bachelors', isDarkMode: isDarkMode),
                  ProfileChip(icon: Icons.height, label: '175 cm', isDarkMode: isDarkMode),
                ],
              ),
              Divider(), // Added divider
              SizedBox(height: 20),
              SectionTitle(title: 'Interest'),
              Wrap(
                spacing: 8.0,
                children: [
                  ProfileChip(icon: Icons.fastfood, label: 'Street Food', isDarkMode: isDarkMode),
                  ProfileChip(icon: Icons.music_note, label: 'Live Music', isDarkMode: isDarkMode),
                  ProfileChip(icon: Icons.travel_explore, label: 'Travel', isDarkMode: isDarkMode),
                  ProfileChip(icon: Icons.book, label: 'Reading', isDarkMode: isDarkMode),
                  ProfileChip(icon: Icons.festival, label: 'Festivals', isDarkMode: isDarkMode),
                ],
              ),
              Divider(), // Added divider
              SizedBox(height: 20),
              SectionTitle(title: 'Lifestyle'),
              Wrap(
                spacing: 8.0,
                children: [
                  ProfileChip(icon: Icons.smoke_free, label: 'Non-smoker', isDarkMode: isDarkMode),
                  ProfileChip(icon: Icons.pets, label: 'Cat', isDarkMode: isDarkMode),
                  ProfileChip(icon: Icons.emoji_nature, label: 'Vegan', isDarkMode: isDarkMode),
                ],
              ),
              Divider(), // Added divider
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen(chatName: 'Daniel')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    'Chat Now',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}

class ProfileChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDarkMode;

  ProfileChip({required this.icon, required this.label, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: AppTextStyles.bodyStyle(context).copyWith(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
      avatar: Icon(
        icon,
        size: 16,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.purple
            : Colors.purpleAccent,
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightChipBackground
          : AppColors.darkChipBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.shade300
              : Colors.grey.shade700,
        ),
      ),
    );
  }
}
*/
