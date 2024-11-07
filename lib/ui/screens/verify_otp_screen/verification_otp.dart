import 'package:flatemates_ui/auth/auth_controller.dart';
import 'package:flatemates_ui/navigation/app_routes/routes.dart';
import 'package:flatemates_ui/res/colors/colors.dart';
import 'package:flatemates_ui/res/font/text_style.dart';
import 'package:flatemates_ui/widgets/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final AuthController authController = Get.put(AuthController());

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
              ? AppColors.lightBackground
              : AppColors.darkBackground,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Icon
            Image.asset(
              'assets/icons/icon.png', // Your app logo path
              height: 80,
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              'Verification Code',
              style: AppTextStyles.largeTitleStyle(context).copyWith(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Instruction Text
            Text(
              'We have already sent the 4-digit code to +91 ${authController.phone}, please fill it in below',
              style: AppTextStyles.bodyStyle(context).copyWith(
                color: Colors.black.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Responsive OTP Input Fields using Wrap
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10, // Adjust the spacing between OTP boxes
              children:
                  List.generate(4, (index) => _buildOTPBox(context, index)),
            ),
            const SizedBox(height: 20),

            // Resend and Verify Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Verify Button
            Center(
              child: Obx(() {
                if (authController.isLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return CustomButton(
                    text: 'Verify',
                    onPressed: () {
                      authController.verifyUser(authController.phone.value);
                      // Navigate to the RegisterUserScreen after verification
                      Get.toNamed(AppRoutes.registerUser);
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
      width: 60,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.primaryColor
              : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        style: AppTextStyles.bodyStyle(context).copyWith(
          fontSize: 24,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        obscureText: true, // Makes the input appear as dots
        maxLength: 1,
        onChanged: (value) => _onChanged(index, value),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
