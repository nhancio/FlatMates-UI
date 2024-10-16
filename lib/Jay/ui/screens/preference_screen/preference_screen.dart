import 'package:flatmates/Jay/navigation/app_routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flatmates/Jay/res/assets/icons/icons.dart';
import 'package:flatmates/Jay/res/colors/colors.dart';
import 'package:flatmates/Jay/res/font/text_style.dart';
import 'package:flatmates/Jay/widgets/custom_button/custom_button.dart';

class PreferenceScreen extends StatelessWidget {
  final List<PreferenceItem> preferenceItems = [
    PreferenceItem(name: 'Pet Lover', iconPath: AppIcons.pet),
    PreferenceItem(name: 'Gym Person', iconPath: AppIcons.gym),
    PreferenceItem(name: 'Travel Person', iconPath: AppIcons.travel),
    PreferenceItem(name: 'Party Person', iconPath: AppIcons.party),
    PreferenceItem(name: 'Music Person', iconPath: AppIcons.music),
    PreferenceItem(name: 'Vegan Person', iconPath: AppIcons.vegan),
    PreferenceItem(name: 'Sports Person', iconPath: AppIcons.sport),
    PreferenceItem(name: 'Yoga Person', iconPath: AppIcons.yoga),
    PreferenceItem(name: 'Non-Alcoholic', iconPath: AppIcons.nonSmoker),
    PreferenceItem(name: 'Shopping Person', iconPath: AppIcons.shopping),
    PreferenceItem(name: 'Friendly Person', iconPath: AppIcons.friends),
    PreferenceItem(name: 'Studious', iconPath: AppIcons.studious),
    PreferenceItem(name: 'Growth', iconPath: AppIcons.growth),
    PreferenceItem(name: 'Non-Smoker', iconPath: AppIcons.nonSmoker),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your preferences'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose at least 5 preferences for better results',
              style: AppTextStyles.bodyStyle(context).copyWith(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                physics: MediaQuery.of(context).size.width > 800
                    ? NeverScrollableScrollPhysics()
                    : BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 800 ? 5 : 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: preferenceItems.length,
                itemBuilder: (context, index) {
                  return _buildPreferenceItem(preferenceItems[index]);
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: CustomButton(
                text: 'Next',
                onPressed: () {
                  Get.toNamed(AppRoutes.bottomNavBar);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceItem(PreferenceItem item) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              item.iconPath,
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PreferenceItem {
  final String name;
  final String iconPath;

  PreferenceItem({required this.name, required this.iconPath});
}
