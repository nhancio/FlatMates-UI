import 'package:flutter/material.dart';
import 'package:flatmates/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({
    required this.icon,
    required this.label,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
              icon,
              color: isDarkMode ? AppColors.darkText : AppColors.lightText
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: isDarkMode ? AppColors.darkText : AppColors.lightText,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
          filled: true,
          fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.purple,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.purple, // Border color when not focused
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.white, // Border color when focused
              width: 2.0, // Increase width to make it more prominent
            ),
          ),
        ),
        style: TextStyle(
          color: isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
      ),
    );
  }
}


class CustomStyledDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final String hintText;
  final IconData icon;
  final String label;
  final ValueChanged<String?> onChanged;
  final bool isDarkMode;

  CustomStyledDropdown({
    required this.selectedValue,
    required this.items,
    required this.hintText,
    required this.icon,
    required this.label,
    required this.onChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.purple,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.purple, // Border color when not focused
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.white, // Border color when focused
            width: 2.0, // Increase width to make it more prominent
          ),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          hint: Text(
            hintText,
            style: TextStyle(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: isDarkMode ? AppColors.darkText : AppColors.lightText,
          ),
          dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
          style: TextStyle(
            color: isDarkMode ? AppColors.darkText : AppColors.lightText,
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class CustomBooleanDropdown extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hintText;
  final bool? selectedValue;
  final ValueChanged<bool?> onChanged;
  final bool isDarkMode;

  CustomBooleanDropdown({
    required this.icon,
    required this.label,
    required this.hintText,
    required this.selectedValue,
    required this.onChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.purple,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.purple, // Border color when not focused
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.white, // Border color when focused
            width: 2.0, // Increase width to make it more prominent
          ),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<bool>(
          value: selectedValue,
          hint: Text(
            hintText,
            style: TextStyle(
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: isDarkMode ? AppColors.darkText : AppColors.lightText,
          ),
          dropdownColor: isDarkMode ? Colors.grey[800] : Colors.white,
          style: TextStyle(
            color: isDarkMode ? AppColors.darkText : AppColors.lightText,
          ),
          items: const [
            DropdownMenuItem<bool>(
              value: true,
              child: Text('Yes'),
            ),
            DropdownMenuItem<bool>(
              value: false,
              child: Text('No'),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}