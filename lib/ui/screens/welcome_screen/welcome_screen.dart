
/// old
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/google_controller.dart';
import '../../../res/assets/images/images.dart';
import '../../../res/colors/colors.dart';
import '../../../res/dimensions/dimensions.dart';
import '../../../res/font/font_size.dart';
import '../../../res/font/text_style.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleController signInController = Get.put(GoogleController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth > 600;
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  Images.firstScreen,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: AppColors.backgroundOpacity.withOpacity(0.5),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal:
                  isWideScreen ? AppDimensions.large : AppDimensions.small,
                  vertical: isWideScreen
                      ? AppDimensions.extraLarge
                      : AppDimensions.medium,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.firstScreenIcon,
                      height: isWideScreen
                          ? AppDimensions.largeImageHeight
                          : AppDimensions.smallImageHeight,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                        height: isWideScreen
                            ? AppDimensions.medium
                            : AppDimensions.small),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: <Color>[
                                Color(0xFF561583),
                                Color(0xFF561583)
                              ],
                            ).createShader(bounds);
                          },
                          child: Text(
                            "HOMEMATES",
                            style:
                            AppTextStyles.largeTitleStyle(context).copyWith(
                              fontSize: isWideScreen ? 34 : 26,
                              fontFamily: AppFonts.familyPoppins,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: <Color>[
                                Color(0xFFb60f6e),
                                Color(0xFFb60f6e)
                              ],
                            ).createShader(bounds);
                          },
                          child: Text(
                            ".AI",
                            style:
                            AppTextStyles.largeTitleStyle(context).copyWith(
                              fontSize: isWideScreen ? 34 : 26,
                              fontFamily: AppFonts.familyPoppins,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: isWideScreen
                            ? AppDimensions.small
                            : AppDimensions.extraSmall),
                    Text(
                      '# Find Roomie With Same Qualities',
                      style: AppTextStyles.bodyStyle(context).copyWith(
                        fontSize: isWideScreen ? 20 : 16,
                        fontFamily: AppFonts.familyPoppins,
                        color: AppColors.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 100),
                    Obx(() {
                      return Container(
                        height: 55, // Fixed height
                        width: 200,
                        child: AnimatedContainer(
                          duration: const Duration(
                              milliseconds: 300), // Animation duration
                          width: signInController
                              .buttonWidth.value, // Dynamically change width

                          curve: Curves.easeInOut, // Animation curve
                          child: ElevatedButton(
                            onPressed: signInController.isLoading.value
                                ? null
                                : signInController.signInWithGoogle,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB60F6E),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: signInController.isLoading.value
                                ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            )
                                :Row(
                              mainAxisAlignment: MainAxisAlignment.center, // Center the content
                              children: [
                                Text(
                                  'Login With',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis, // Prevent overflow of text
                                  maxLines: 1, // Ensure the text stays on one line
                                ),
                                SizedBox(width: 9), // Optional spacing between text and icon
                                Image.asset(
                                  'assets/icons/google.png',
                                  height: 24,
                                  width: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: isWideScreen ? 60 : 100),
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

/// new
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/google_controller.dart';
import '../../../res/assets/images/images.dart';
import '../../../res/colors/colors.dart';
import '../../../res/dimensions/dimensions.dart';
import '../../../res/font/text_style.dart';
import 'dart:html' as html;
class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GoogleController signInController = Get.put(GoogleController());

  @override
  void initState() {
    super.initState();
    _clearCacheIfNeeded();
  }

  void _clearCacheIfNeeded() async {
    // Check if cache has already been cleared in this session
    if (html.window.localStorage['cacheCleared'] != 'true') {
      html.window.localStorage.clear();
      html.window.sessionStorage.clear();

      // Set flag to avoid cache clearing again
      html.window.localStorage['cacheCleared'] = 'true';

      // Delay the reload to allow UI rendering first
      await Future.delayed(Duration(milliseconds: 500));
      html.window.location.reload(); // Reload the page after the UI is built
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWideScreen = constraints.maxWidth > 600;
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  Images.firstScreen,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: AppColors.backgroundOpacity.withOpacity(0.5),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal:
                  isWideScreen ? AppDimensions.large : AppDimensions.small,
                ),
                child: SingleChildScrollView(
                  child: SizedBox(
                   height: constraints.maxHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 40,),
                        Image.asset(
                         "assets/icons/icon.png",
                          height: 80,
                          width: 80,

                        ),
                        SizedBox(height: 80,),
                        Image.asset(
                          Images.firstScreenIcon,
                          height: isWideScreen
                              ? AppDimensions.largeImageHeight
                              : AppDimensions.smallImageHeight,
                        ),
                        SizedBox(
                          height: isWideScreen ? AppDimensions.medium : AppDimensions.small,
                        ),
                        Text(
                          "HOMEMATES",
                          style: AppTextStyles.largeTitleStyle(context).copyWith(
                            fontSize: isWideScreen ? 34 : 26,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: isWideScreen ? AppDimensions.small : AppDimensions.extraSmall,
                        ),
                        Text(
                          'Find rooms and roommates based on your preferences',
                          style: AppTextStyles.bodyStyle(context).copyWith(
                            fontSize: isWideScreen ? 20 : 16,
                            color: AppColors.textColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 80),
                        Obx(() {
                          return SizedBox(
                            width: 200,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: signInController.isLoading.value
                                  ? null
                                  : signInController.signInWithGoogle,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB60F6E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: signInController.isLoading.value
                                  ? const CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                                  : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Login With',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Image.asset(
                                    'assets/icons/google.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
