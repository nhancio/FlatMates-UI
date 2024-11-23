import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth/auth_controller.dart';
import '../../../navigation/app_routes/routes.dart';
import '../../../res/colors/colors.dart';
import '../../../res/dimensions/dimensions.dart';
import '../../../res/font/text_style.dart';
import '../../../widgets/custom_button/custom_button.dart';

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
  void initState() {
    super.initState();

    // Add focus listeners to each FocusNode to detect focus changes
    for (var focusNode in _focusNodes) {
      focusNode.addListener(() {
        setState(() {}); // Trigger a rebuild when focus changes
      });
    }
  }

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.lightBackground
                : AppColors.darkBackground,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height > 600 ? 60 : 100,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/icons/icon.png',
                  height: 80,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height > 600 ? 60 : 100,
              ),
              Text(
                'Verification Code',
                style: AppTextStyles.largeTitleStyle(context).copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.small),
              Text(
                'We have already sent the 4-digit code to +91 ${authController.phone}, please fill it in below',
                style: AppTextStyles.bodyStyle(context).copyWith(
                  color: Colors.black.withOpacity(0.6),
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: AppDimensions.extraLarge),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  children:
                      List.generate(4, (index) => _buildOTPBox(context, index)),
                ),
              ),
              const SizedBox(height: 20),
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
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height > 600 ? 140 : 140,
              ),
              Center(
                child: Obx(() {
                  if (authController.isLoading.value) {
                    return const CircularProgressIndicator();
                  } else {
                    return CustomButton(
                      text: 'Verify',
                      onPressed: () {
                        authController.verifyUser(authController.phone.value);
                        Get.toNamed(AppRoutes.registerUser);
                      },
                    );
                  }
                }),
              ),
            ],
          ),
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
        color:
            _focusNodes[index].hasFocus ? Colors.grey[200] : Colors.transparent,
        border: Border.all(
          color: _focusNodes[index].hasFocus
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
        obscureText: true,
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
