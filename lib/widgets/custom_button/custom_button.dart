import 'package:flatemates_ui/res/font/font_size.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(300, 50),
        backgroundColor: Color(0xFFB60F6E),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: AppFonts.familyPoppins,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
