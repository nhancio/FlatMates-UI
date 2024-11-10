
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth/auth_controller.dart';
import '../../../navigation/app_routes/routes.dart';
import '../../../res/assets/icons/icons.dart';
import '../../../res/dimensions/dimensions.dart';
import '../../../res/font/text_style.dart';
import '../../../widgets/custom_button/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to left
              children: [
                // Top Icon Bar
                SizedBox(
                  height: MediaQuery.of(context).size.height > 600 ? 60 : 100,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppIcons.icon, // App icon
                    height: 80, // Adjust the height as needed
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height > 600 ? 60 : 100,
                ),

                // Login/Register Title
                Text(
                  'Login/Register',
                  style: AppTextStyles.largeTitleStyle(context).copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: AppDimensions.extraLarge),

                // Description Text
                Text(
                  'By entering a valid phone number you can easily log in and get access to your account',
                  style: AppTextStyles.bodyStyle(context).copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: AppDimensions.extraLarge),

                // Responsive Phone Number Input with Flag and Down Arrow
                LayoutBuilder(
                  builder: (context, constraints) {
                    double inputWidth = constraints.maxWidth > 600
                        ? constraints.maxWidth * 0.3
                        : constraints.maxWidth * 0.85;

                    return Center(
                      child: Container(
                        width: inputWidth,
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Enter Number',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(vertical: AppDimensions.textFieldHeight / 2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0), // Customize as needed
                            ),
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Image.asset(
                                    AppIcons.flag, // Country flag icon
                                    height: 24,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                ),
                                const VerticalDivider(
                                  width: 1,
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),

                          ),
                        ),
                      ),
                    );


                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height > 600 ? 120 : 120,
                ),

                // Request OTP Button
                Center(
                  child: CustomButton(
                    text: 'Request OTP',
                    onPressed: () {
                      authController.phone.value = phoneController.text;
                      Get.toNamed(AppRoutes.verification);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
