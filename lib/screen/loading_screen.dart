/*
import 'package:flatmates/screen/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:flatmates/widgets/custom_button.dart';

class LoadingScreen extends StatelessWidget {
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
            Image.asset('assets/images/img.png', height: 300), // Replace with your image
            SizedBox(height: 20),
            CustomButton(
              text: 'Process',
              onPressed: () {
                Get.to(() => UserInformationScreen());  // Use GetX for navigation
              },
            ),
            SizedBox(height: 10),
            Text(
              'Build customized experience',
              style: AppTextStyles.bodyStyle(context).copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.lightText
                    : AppColors.darkSubText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
