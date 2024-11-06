/*
import 'package:flutter/material.dart';
import 'package:flatmates/theme/app_colors.dart';

class Text_Field extends StatelessWidget {
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final String hintText;
  final TextEditingController controller;


  const Text_Field({
    Key? key,
    required this.keyboardType,
    this.prefixIcon,
    required this.hintText,
    required this.controller

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: keyboardType,
controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.grey[800],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.lightText
                  : AppColors.darkText,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.lightText
              : AppColors.darkText,
        ),
      ),
    );
  }
}
*/
