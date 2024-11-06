/*
import 'package:flutter/material.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';

class RoomProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
          onPressed: () {
            // Handle back action
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/room.png',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        '80% Matched',
                        style: AppTextStyles.bodyStyle(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20,
                          child: Text(
                            'D',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daniel, 26',
                              style: AppTextStyles.largeTitleStyle(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Artist',
                              style: AppTextStyles.bodyStyle(context).copyWith(
                                color: Colors.white,
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
            buildInfoSection(context, 'Basics', [
              buildInfoItem(context, 'Age', Icons.cake),
              buildInfoItem(context, 'Bachelors', Icons.school),
              buildInfoItem(context, '175 cm', Icons.height),
            ]),
            SizedBox(height: 10),
            buildInfoSection(context, 'Amenities', [
              buildInfoItem(context, 'Fridge', Icons.kitchen),
              buildInfoItem(context, 'Kitchen', Icons.restaurant),
              buildInfoItem(context, 'WiFi', Icons.wifi),
              buildInfoItem(context, 'Reading', Icons.book),
            ]),
            SizedBox(height: 10),
            buildInfoSection(context, 'Lifestyle', [
              buildInfoItem(context, 'Non-smoker', Icons.smoke_free),
              buildInfoItem(context, 'Cat', Icons.pets),
              buildInfoItem(context, 'Vegan', Icons.eco),
              buildInfoItem(context, 'On special occasions', Icons.celebration),
            ]),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle Chat Now action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                'Chat Now',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleStyle(context).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: children,
        ),
        Divider(),
      ],
    );
  }

  Widget buildInfoItem(BuildContext context, String label, IconData icon) {
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
