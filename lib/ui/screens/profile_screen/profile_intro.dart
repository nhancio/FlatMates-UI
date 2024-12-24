import 'package:flatemates_ui/controllers/google_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileIntroScreen extends StatefulWidget {
  ProfileIntroScreen({super.key});

  @override
  State<ProfileIntroScreen> createState() => _ProfileIntroScreenState();
}

class _ProfileIntroScreenState extends State<ProfileIntroScreen> {
  // GetX controller for managing the user profile
  final GoogleController profileController = Get.put(GoogleController());

  // Controllers for text fields (UI binding)
  final TextEditingController genderController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController professsionController = TextEditingController();

  final TextEditingController foodChoiceController = TextEditingController();

  final TextEditingController drinkingController = TextEditingController();

  final TextEditingController smokingController = TextEditingController();

  final TextEditingController petController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Colors.purple, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.purple, width: 2),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/icons/danile.png',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileController.userProfile.value.userName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                              softWrap: true,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              profileController
                                  .userProfile.value.userPhoneNumber,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Profile Fields
                _buildTextField('Gender', genderController,
                    profileController.userProfile.value.gender),
                _buildTextField('Age', ageController,
                    profileController.userProfile.value.age.toString()),
                _buildTextField('Profession', professsionController,
                    profileController.userProfile.value.profession),
                const SizedBox(height: 20),

                // Preferences Section
                const Text(
                  'Preferences',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildPreferenceRow(),
                const SizedBox(height: 20),
                // Save Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Call the saveProfile function from the controller
                      profileController.saveProfile(
                        gender: genderController.text,
                        age: int.tryParse(ageController.text) ?? 0,
                        location: professsionController.text,
                        foodChoice: foodChoiceController.text,
                        drinking: drinkingController.text,
                        smoking: smokingController.text,
                        pet: petController.text,
                        preferences: [
                          'Non-Smoker',
                          'Yoga Person'
                        ], // Example preferences, replace with actual logic
                      );
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPreferenceRow() {
    List<Map<String, String>> preferences = [
      {'title': 'Non-Smoker', 'icon': 'assets/icons/non_smoker.png'},
      {'title': 'Travel Person', 'icon': 'assets/icons/travel.png'},
      {'title': 'Studious', 'icon': 'assets/icons/studious.png'},
      {'title': 'Yoga Person', 'icon': 'assets/icons/yoga.png'},
      {'title': 'Music Person', 'icon': 'assets/icons/music.png'},
      {'title': 'Non-Alcoholic', 'icon': 'assets/icons/alcoholic.png'},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: preferences.map((pref) {
        return Column(
          children: [
            Image.asset(
              pref['icon']!,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 4),
            Text(
              pref['title']!,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        );
      }).toList(),
    );
  }

  // Builds the text field for each profile property
  Widget _buildTextField(
      String label, TextEditingController controller, String initialValue) {
    controller.text = initialValue;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
