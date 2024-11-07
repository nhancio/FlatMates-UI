// lib/theme/app_text_styles.dart

import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle largeTitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge!.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bodyStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 16,
      color: Colors.black,
    );
  }
}
