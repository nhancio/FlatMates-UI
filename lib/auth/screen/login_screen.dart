import 'package:flatmates/controllers/auth_controller.dart';
import 'package:flatmates/routes/app_routes.dart';
import 'package:flatmates/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:flatmates/widgets/custom_button.dart';
import 'package:flatmates/widgets/custom_text_field.dart';
import 'package:flatmates/theme/app_assets.dart';

class LoginScreen extends StatelessWidget {
     final AuthController authController =
      Get.put(AuthController());
      final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.lightBackground  // Use centralized color
              : AppColors.darkBackground,  // Use centralized color
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login/Sign Up',
              style: AppTextStyles.largeTitleStyle(context).copyWith(
                fontSize: 32,  // Specific style adjustment
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'By entering a valid phone number you can easily log in and get access to your account',
              style: AppTextStyles.bodyStyle(context),
            ),
            const SizedBox(height: 20),
            Text_Field(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(AppAssets.indiaFlag, width: 24),
                    const SizedBox(width: 8),
                    const Text(
                      '+91',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              hintText: '9876543210',
            ),
            const SizedBox(height: 30),
            Center(
              child: CustomButton(
                text: 'Request OTP',
                onPressed: () {
                  authController.phone=phoneController.text;
                  Get.toNamed(AppRoutes.VERIFICATION);
                  // Use GetX for navigation
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
