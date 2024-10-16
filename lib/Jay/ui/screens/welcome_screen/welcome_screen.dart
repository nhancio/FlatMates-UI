import 'package:flatmates/Jay/navigation/app_routes/routes.dart';
import 'package:flatmates/Jay/res/assets/images/images.dart';
import 'package:flatmates/Jay/res/colors/colors.dart';
import 'package:flatmates/Jay/res/dimensions/dimensions.dart';
import 'package:flatmates/Jay/res/font/font_size.dart';
import 'package:flatmates/Jay/res/font/text_style.dart';
import 'package:flatmates/Jay/widgets/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth > 600; // 600px is a breakpoint for wide screens

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
                  color: AppColors.backgroundOpacity.withOpacity(0.68),
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
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: <Color>[
                            Color(0xFF824CF2),
                            Color(0xFFCC2584),
                          ],
                        ).createShader(bounds);
                      },
                      child: Text(
                        "Homemates.AI",
                        style: AppTextStyles.largeTitleStyle(context).copyWith(
                          fontSize: isWideScreen ? 32 : 24, // Responsive font size
                          fontFamily: AppFonts.familyPoppins,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: isWideScreen ? AppDimensions.small : AppDimensions.extraSmall),

                    // Tagline
                    Text(
                      '# Find roomie with same Qualities',
                      style: AppTextStyles.bodyStyle(context).copyWith(
                        fontSize: isWideScreen ? 18 : 14,
                        fontFamily: AppFonts.familyPoppins,
                        color: AppColors.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isWideScreen ? 60 : 50),

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

