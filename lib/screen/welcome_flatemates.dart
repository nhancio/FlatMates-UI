/*
  import 'package:flatmates/routes/app_routes.dart';
import 'package:flatmates/widgets/bottomBar.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:flatmates/theme/app_text_styles.dart';
  import 'package:flatmates/theme/app_colors.dart';
  import 'package:flatmates/widgets/custom_button.dart';
  import 'package:flatmates/theme/app_assets.dart';

  class WelcomeToFlatmateScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.lightBackground  // Use centralized color
                : AppColors.darkBackground,  // Use centralized color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.home, height: 200), // Use centralized asset
              SizedBox(height: 20),
              Text(
                'WELCOME',
                style: AppTextStyles.largeTitleStyle(context).copyWith(
                  fontSize: 40,  // Larger font size for emphasis
                  fontWeight: FontWeight.w600,  // Semi-bold weight
                  letterSpacing: 2.0,  // Increase spacing for visual appeal
                ),
              ),
              Text(
                'to',
                style: AppTextStyles.titleStyle(context).copyWith(
                  fontSize: 24,  // Smaller font size for "to"
                  fontWeight: FontWeight.normal,  // Normal weight
                  letterSpacing: 1.0,  // Slight letter spacing
                ),
              ),
              Text(
                'FLATMATE.AI',
                style: AppTextStyles.largeTitleStyle(context).copyWith(
                  fontSize: 40,  // Larger font size matching "WELCOME"
                  fontWeight: FontWeight.w600,  // Semi-bold weight
                  letterSpacing: 2.0,  // Matching spacing for uniformity
                ),
              ),
              SizedBox(height: 8),
              Text(
                '# Find Roomie With Same Qualities',
                style: AppTextStyles.subtitleStyle(context).copyWith(
                  fontSize: 14,  // Smaller, more subtle font size
                  fontStyle: FontStyle.italic,  // Italicized for emphasis
                  fontWeight: FontWeight.w400,  // Normal weight
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              CustomButton(
                text: 'Start',
                onPressed: () {
                  Get.toNamed(AppRoutes.CREATE_ACCOUNT);  // Use GetX for navigation
                },
              ),
            ],
          ),
        ),
      );
    }
  }
*/

//profile screen
/*
import 'package:flatmates/screen/speech_text_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:flatmates/widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLookingForFlatmate = false;
  bool isLookingForRoom = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.lightBackground  // Use centralized color
                : AppColors.darkBackground,  // Use centralized color
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'About You',
                    style: AppTextStyles.titleStyle(context),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.add_photo_alternate),
                            onPressed: () {
                              // Handle photo upload action
                            },
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Upload Photos',
                        style: AppTextStyles.captionStyle(context).copyWith(
                          color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.lightSubText
                              : AppColors.darkSubText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildListTile(context, Icons.work, 'Profession'),
              _buildListTile(context, Icons.person, 'Gender'),
              _buildListTile(context, Icons.cake, 'Age'),
              _buildListTile(context, Icons.location_on, 'Location'),
              _buildListTile(context, Icons.local_drink, 'Drinking'),
              _buildListTile(context, Icons.smoking_rooms, 'Smoking'),
              _buildListTile(context, Icons.favorite, 'Interest'),
              _buildListTile(context, Icons.pets, 'Pet'),
              SizedBox(height: 20),

              // Toggle for "Looking for Flatmate"
              SwitchListTile(
                title: Text(
                  'Looking for Flatmate',
                  style: AppTextStyles.bodyStyle(context),
                ),
                value: isLookingForFlatmate,
                activeColor: Colors.purple,
                onChanged: (bool value) {
                  setState(() {
                    isLookingForFlatmate = value;
                  });
                },
              ),

              // Toggle for "Looking for Room"
              SwitchListTile(
                title: Text(
                  'Looking for Room',
                  style: AppTextStyles.bodyStyle(context),
                ),
                value: isLookingForRoom,
                activeColor: Colors.purple,
                onChanged: (bool value) {
                  setState(() {
                    isLookingForRoom = value;
                  });
                },
              ),

              // Button for "List My Room"
              ListTile(
                title: Text(
                  'List My Room',
                  style: AppTextStyles.bodyStyle(context),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.purple),
                onTap: () {
                  // Handle List My Room action
                },
              ),

              SizedBox(height: 20),
              Center(
                child: CustomButton(
                  text: 'Next',
                  onPressed: () {
                    Get.to(() => SpeechTextScreen()); // Use GetX for navigation
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.lightText
            : AppColors.darkText,
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyStyle(context),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.lightText
            : AppColors.darkText,
      ),
      onTap: () {
        // Handle list tile action
      },
    );
  }
}
*/
