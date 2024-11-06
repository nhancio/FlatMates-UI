/*
import 'package:flatmates/controllers/auth_controller.dart';
import 'package:flatmates/routes/app_routes.dart';
import 'package:flatmates/screen/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:flatmates/widgets/custom_button.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
       final AuthController authController =
      Get.put(AuthController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < _focusNodes.length - 1) {
        _focusNodes[index].unfocus();
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    } else {
      if (index > 0) {
        _focusNodes[index].unfocus();
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      }
    }
  }

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
              'Verification',
              style: AppTextStyles.largeTitleStyle(context).copyWith(
                fontSize: 32, // Specific style adjustment
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'We have already sent the 4-digit code to +91 ${authController.phone}, please fill it in below',
              style: AppTextStyles.bodyStyle(context),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) => _buildOTPBox(context, index)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Didn't receive SMS? ",
                  style: AppTextStyles.bodyStyle(context),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle resend OTP
                  },
                  child: Text(
                    'Resend',
                    style: AppTextStyles.bodyStyle(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
             Center(
              child: Obx(() {
                if (authController.isLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return CustomButton(
                    text: 'Verify',
                    onPressed: () {
                      // Assuming OTP input is implemented and the collected OTP is stored in the 'otp' variable
                      authController.verifyUser(authController.phone);
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPBox(BuildContext context, int index) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.lightText  // Use centralized color
              : AppColors.darkText,  // Use centralized color
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        style: AppTextStyles.bodyStyle(context).copyWith(
          fontSize: 24, // Specific style adjustment
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        obscureText: true,  // Makes the text appear as dots
        maxLength: 1,  // Limits the input to 1 digit
        onChanged: (value) => _onChanged(index, value),
        decoration: const InputDecoration(
          counterText: '',  // Hides the character counter
          border: InputBorder.none,
        ),
      ),
    );
  }
}
*/
