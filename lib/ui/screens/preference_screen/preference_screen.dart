import 'package:flatemates_ui/controllers/preference_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  final List<PreferenceItem> preferenceItems = [
    PreferenceItem(name: 'Pet Lover', iconPath: 'assets/icons/pet.png'),
    PreferenceItem(name: 'Gym Person', iconPath: 'assets/icons/gym.png'),
    PreferenceItem(name: 'Travel Person', iconPath: 'assets/icons/travel.png'),
    PreferenceItem(name: 'Party Person', iconPath: 'assets/icons/party.png'),
    PreferenceItem(name: 'Music Person', iconPath: 'assets/icons/music.png'),
    PreferenceItem(name: 'Vegan Person', iconPath: 'assets/icons/vegan.png'),
    PreferenceItem(name: 'Sports Person', iconPath: 'assets/icons/sport.png'),
    PreferenceItem(name: 'Yoga Person', iconPath: 'assets/icons/yoga.png'),
    PreferenceItem(
        name: 'Non-Alcoholic', iconPath: 'assets/icons/alcoholic.png'),
    PreferenceItem(
        name: 'Shopping Person', iconPath: 'assets/icons/shopping.png'),
    PreferenceItem(
        name: 'Friendly Person', iconPath: 'assets/icons/friends.png'),
    PreferenceItem(name: 'Studious', iconPath: 'assets/icons/studious.png'),
    PreferenceItem(name: 'Growth', iconPath: 'assets/icons/growth.png'),
    PreferenceItem(name: 'Non-Smoker', iconPath: 'assets/icons/non_smoker.png'),
  ];

  List<String> selectedPreferences = [];
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:25),
            Center(
              child: Text(
                'Choose your preferences',
                style: TextStyle(
                    fontSize: screenWidth > 800 ? 28 : 24,
                    fontWeight: FontWeight.bold),
              ),
            ),

            Center(
              child: Padding(
                padding:  EdgeInsets.fromLTRB(8,10,8,10),
                child: Text(
                  textAlign: TextAlign.start,
                  'Choose at least 5 preferences for better results',
                  style: TextStyle(
                      fontSize: screenWidth > 800 ? 18 : 16,
                      color: Colors.grey[600]),
                ),
              ),
            ),

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

            if (errorMessage != null) ...[
              Center(
                child: Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),

            ],

            Center(
              child: SizedBox(
                width: screenWidth > 600 ? 250 : 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedPreferences.length >= 5) {
                      setState(() {
                        errorMessage = null;
                      });
                      // Call the GetX controller method to save preferences
                      final controller = Get.find<PreferenceController>();
                      controller.savePreferences(selectedPreferences);
                    } else {
                      setState(() {
                        errorMessage = 'Please select at least 5 preferences.';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB60F6E),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Increase padding for bigger button

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Next', style: TextStyle(fontSize: 18,color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 800) {
      return 5; // For large screens (desktop/tablet)
    } else if (screenWidth > 600) {
      return 4; // For medium screens (tablet)
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Color(0xFFB60F6E) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              item.iconPath,
              fit: BoxFit.cover,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 8),
            Text(item.name,overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
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
