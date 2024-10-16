import 'package:flatmates/Jay/auth/auth_controller.dart';
import 'package:flatmates/Jay/navigation/app_routes/routes.dart';
import 'package:flatmates/Jay/res/assets/icons/icons.dart';
import 'package:flatmates/Jay/res/assets/images/images.dart';
import 'package:flatmates/Jay/res/dimensions/dimensions.dart';
import 'package:flatmates/Jay/res/font/text_style.dart';
import 'package:flatmates/Jay/widgets/custom_button/custom_button.dart';
import 'package:flatmates/Jay/widgets/custom_textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Icon
                Image.asset(
                  AppIcons.icon, // App icon
                  height: 80, // Adjust the height as needed
                ),
                const SizedBox(height: AppDimensions.large),

                // Login/Register Title
                Text(
                  'Login/Register',
                  style: AppTextStyles.largeTitleStyle(context).copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: AppDimensions.small),

                // Description Text
                Text(
                  'By entering a valid phone number you can easily log in and get access to your account',
                  style: AppTextStyles.bodyStyle(context).copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppDimensions.large),

                // Responsive Phone Number Input with Flag
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate the width based on screen size
                    double inputWidth = constraints.maxWidth > 600
                        ? constraints.maxWidth * 0.5
                        : constraints.maxWidth * 0.85;

                    return Container(
                      width: inputWidth,
                      child: Row(
                        children: [
                          Image.asset(
                            AppIcons.flag, // Country flag icon
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: CustomTextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              hintText: 'Enter Number',
                              height: AppDimensions.textFieldHeight,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppDimensions.large),

                // Request OTP Button
                CustomButton(
                  text: 'Request OTP',
                  onPressed: () {
                    authController.phone.value = phoneController.text;
                    // Uncomment the below line to navigate to the verification screen
                    Get.toNamed(AppRoutes.verification);
                  },
                ),
              // Background Image (optional, can be used for decoration)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
