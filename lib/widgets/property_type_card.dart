import 'package:flutter/material.dart';

class PropertyTypeCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const PropertyTypeCard({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFB60F6E).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFFB60F6E) : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              width: 40,
              height: 40,
              color: isSelected ? Color(0xFFB60F6E) : Colors.grey[600],
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Color(0xFFB60F6E) : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}