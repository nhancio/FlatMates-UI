
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../navigation/app_routes/routes.dart';
import '../../../res/assets/images/images.dart';
import '../../../res/colors/colors.dart';
import '../../../res/dimensions/dimensions.dart';
import '../../../res/font/font_size.dart';
import '../../../res/font/text_style.dart';
import '../../../widgets/custom_button/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth > 600;

        return Scaffold(
          body: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  Images.firstScreen,
                  fit: BoxFit.cover,
                ),
              ),

              // Background Opacity Layer
              Positioned.fill(
                child: Container(
                  color: AppColors.backgroundOpacity.withOpacity(0.5),
                ),
              ),

              // Foreground Content
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isWideScreen ? AppDimensions.large : AppDimensions.small,
                  vertical: isWideScreen ? AppDimensions.extraLarge : AppDimensions.medium,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image Section
                    Image.asset(
                      Images.firstScreenIcon,
                      height: isWideScreen ? AppDimensions.largeImageHeight : AppDimensions.smallImageHeight,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: isWideScreen ? AppDimensions.medium : AppDimensions.small),

                    // Title Section with Gradient Text
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: <Color>[Color(0xFF561583), Color(0xFF561583)],
                            ).createShader(bounds);
                          },
                          child: Text(
                            "HOMEMATES",
                            style: AppTextStyles.largeTitleStyle(context).copyWith(
                              fontSize: isWideScreen ? 34 : 26, // Responsive font size
                              fontFamily: AppFonts.familyPoppins,
                              color: Colors.white, // White to ensure the shader shows
                            ),
                          ),
                        ),
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: <Color>[Color(0xFFb60f6e), Color(0xFFb60f6e)],
                            ).createShader(bounds);
                          },
                          child: Text(
                            ".AI",
                            style: AppTextStyles.largeTitleStyle(context).copyWith(
                              fontSize: isWideScreen ? 34 : 26, // Responsive font size
                              fontFamily: AppFonts.familyPoppins,
                              color: Colors.white, // White to ensure the shader shows
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: isWideScreen ? AppDimensions.small : AppDimensions.extraSmall),

                    // Tagline
                    Text(
                      '# Find Roomie With Same Qualities',
                      style: AppTextStyles.bodyStyle(context).copyWith(
                        fontSize: isWideScreen ? 20 : 16,
                        fontFamily: AppFonts.familyPoppins,
                        color: AppColors.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isWideScreen ? 60 : 100),

                    // Button Section
                    Center(
                      child: CustomButton(
                        text: 'Login/Sign Up',
                        onPressed: () {
                          Get.toNamed(AppRoutes.register); // Use GetX for navigation
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

