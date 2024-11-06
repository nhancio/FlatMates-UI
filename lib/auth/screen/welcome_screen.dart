/*
import 'package:flatmates/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth > 600; // Adjust for wide screens
        return Scaffold(
          body: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  "assets/images/first_page.png",  // Use your uploaded image here
                  fit: BoxFit.cover,  // Ensure the image covers the whole screen
                ),
              ),

              // Background Opacity Layer
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.68),  // Set the opacity here
                ),
              ),

              // Foreground Content
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isWideScreen ? 50.0 : 20.0,
                  vertical: isWideScreen ? 40.0 : 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image Section
                    Image.asset(
                      "assets/images/first_icon.png",
                      height: isWideScreen ? 300 : 200,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: isWideScreen ? 30 : 20),

                    // Title Section with Gradient Text
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: <Color>[

                            Color(0xFF824CF2), // Customize the color here
                            Color(0xFFCC2584), // Customize the color here
                          ],
                        ).createShader(bounds);
                      },
                      child: Text(
                        "Homemates.AI",
                        style: AppTextStyles.largeTitleStyle(context).copyWith(
                          fontSize: isWideScreen ? 32 : 24,
                          color: Colors.white, // This will be masked by the gradient
                        ),
                      ),
                    ),
                    SizedBox(height: isWideScreen ? 15 : 8),

                    // Tagline
                    Text(
                      '# Find roomie with same Qualities',
                      style: AppTextStyles.bodyStyle(context).copyWith(
                        fontSize: isWideScreen ? 18 : 14,
                        color: Colors.black, // Darker color for the tagline
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isWideScreen ? 60 : 50),

                    // Button Section
                    SizedBox(
                      width: isWideScreen ? 300 : double.infinity, // Adjust button width for wide screens
                      child: CustomButton(
                        text: 'Login/Sign Up',
                        onPressed: () {
                          Get.toNamed(AppRoutes.LOGIN);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
*/
