import 'package:flatmates/routes/app_routes.dart';
import 'package:flatmates/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:flatmates/widgets/custom_button.dart';
import 'package:flatmates/theme/app_assets.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.lightBackground  // Light background color from AppColors
              : AppColors.darkBackground,  // Dark background color from AppColors
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.login, height: 200),
            SizedBox(height: 20),
            Text(
              'FLATMATE.AI',
              style: AppTextStyles.largeTitleStyle(context), // Use centralized text style
            ),
            SizedBox(height: 8),
            Text(
              '# Find Roomie With Same Qualities',
              style: AppTextStyles.bodyStyle(context), // Use centralized text style
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            CustomButton(
              text: 'Login/Sign Up',
              onPressed: () {
                Get.toNamed(AppRoutes.LOGIN); // Use GetX for navigation
              },
            ),
          ],
        ),
      ),
    );
  }
}
