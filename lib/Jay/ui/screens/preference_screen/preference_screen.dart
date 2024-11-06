import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flatemates_ui/Jay/navigation/app_routes/routes.dart';
import 'package:flatemates_ui/Jay/res/assets/icons/icons.dart';
import 'package:flatemates_ui/Jay/res/colors/colors.dart';
import 'package:flatemates_ui/Jay/res/font/text_style.dart';
import 'package:flatemates_ui/Jay/widgets/custom_button/custom_button.dart';

class PreferenceScreen extends StatefulWidget {
  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
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

  List<String> selectedPreferences = [];
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your preferences'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (errorMessage != null) ...[
                Center(
                  child: Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 10),
              ],
              Center(
                child: Text(
                  'Choose at least 5 preferences for better results',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyStyle(context).copyWith(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(context),
                  mainAxisSpacing: _getSpacing(context),
                  crossAxisSpacing: _getSpacing(context),
                  childAspectRatio: 1,
                ),
                itemCount: preferenceItems.length,
                itemBuilder: (context, index) {
                  return _buildPreferenceItem(context, preferenceItems[index]);
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomButton(
                  text: 'Next',
                  onPressed: () {
                    if (selectedPreferences.length >= 5) {
                      setState(() {
                        errorMessage = null;
                      });
                      Get.toNamed(AppRoutes.bottomNavBar);
                    } else {
                      setState(() {
                        errorMessage = 'Please select at least 5 preferences.';
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 800) {
      return 5; // For larger screens
    } else if (screenWidth > 600) {
      return 4; // Medium screen
    } else {
      return 3; // For mobile
    }
  }

  double _getSpacing(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 800) {
      return 8.0; // Less spacing on web
    } else if (screenWidth > 600) {
      return 10.0; // Slightly more space for medium screens
    } else {
      return 12.0; // Larger space for mobile
    }
  }

  Widget _buildPreferenceItem(BuildContext context, PreferenceItem item) {
    double iconSize = MediaQuery.of(context).size.width > 800 ? 50 : 60; // Smaller icon for web
    double padding = MediaQuery.of(context).size.width > 800 ? 4.0 : 8.0;

    bool isSelected = selectedPreferences.contains(item.name);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedPreferences.remove(item.name);
          } else {
            selectedPreferences.add(item.name);
          }
        });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  item.iconPath,
                  fit: BoxFit.cover,
                  height: iconSize,
                  width: iconSize,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.name,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreferenceItem {
  final String name;
  final String iconPath;

  PreferenceItem({required this.name, required this.iconPath});
}
