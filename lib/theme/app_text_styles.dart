import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle largeTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      height: 1.5,  // Adding line height
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightText
          : AppColors.darkText,
    );
  }

  static TextStyle titleStyle(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightText
          : AppColors.darkText,
    );
  }

  static TextStyle subtitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightSubText
          : AppColors.darkSubText,
    );
  }

  static TextStyle bodyStyle(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 1.5,  // Adding line height
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightText
          : AppColors.darkText,
    );
  }

  // This is the subTextStyle method
  static TextStyle subTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightSubText
          : AppColors.darkSubText,
    );
  }

  static TextStyle captionStyle(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightSubText
          : AppColors.darkSubText,
    );
  }

  static TextStyle buttonTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
    );
  }

  static TextStyle smallTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightSubText
          : AppColors.darkSubText,
    );
  }

  static TextStyle overlineStyle(BuildContext context) {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.5,  // Adds spacing between letters
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightSubText
          : AppColors.darkSubText,
    );
  }

  static TextStyle customColorStyle(BuildContext context, Color color, {double fontSize = 16}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      color: color,
    );
  }

  static TextStyle emphasizedTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightText
          : AppColors.darkText,
      shadows: [
        Shadow(
          blurRadius: 2.0,
          color: Colors.black26,
          offset: Offset(2.0, 2.0),
        ),
      ],
    );
  }
}
