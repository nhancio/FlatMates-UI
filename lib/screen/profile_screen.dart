/*
import 'package:flatmates/screen/user_info_screen.dart';
import 'package:flatmates/screen/your_room_details.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLookingForFlatmate = false;
  bool isLookingForRoom = false;
  bool isListingRoom = false;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Label
              Center(
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8),
              // Profile Section
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // Profile Image
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/daniel.png'),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Jash 25',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Settings, Edit Profile, Add Media Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildProfileButton(context, Icons.edit, 'Edit Profile', onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserInformationScreen()),
                    );
                  }),
                  _buildProfileButton(context, Icons.camera_alt, 'Add Media', onPressed: () {
                    // Handle Add Media button press
                  }),
                ],
              ),
              SizedBox(height: 20),
              // Toggle Buttons
              SwitchListTile(
                title: Text(
                  "Looking for Flatmate",
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                value: isLookingForFlatmate,
                activeColor: Colors.purpleAccent,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    isLookingForFlatmate = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text(
                  "Looking for Room",
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                value: isLookingForRoom,
                activeColor: Colors.purpleAccent,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    isLookingForRoom = value;
                  });
                },
              ),
              // List My Room Button
              ListTile(
                title: Text(
                  'List My Room',
                  style: AppTextStyles.bodyStyle(context),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.purple),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => YourRoomDetails()),
                  );
                },
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
              Divider(),
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
              Divider(),
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
              Divider(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context, IconData icon, String label, {required VoidCallback onPressed}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey.shade800,
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.lightSubText
                : AppColors.darkSubText,
          ),
        ),
      ],
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
