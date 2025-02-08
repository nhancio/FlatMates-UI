import 'package:flatemates_ui/Jay/ui/screens/profile_screen/profile_screen.dart';
import 'package:flatemates_ui/controllers/google_controller.dart';
import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
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

        elevation: 0,
          backgroundColor: const Color(0xfff8e6f1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Color(0xFFB60F6E),),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BottomNavBarScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var tween = Tween(
                      begin: const Offset(0.0, 0.0), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.ease));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );

          },
        ),
        title: const Text(
          'Profile Details',
    style: TextStyle(color: Color(0xFFB60F6E)),
    )),
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
                    border: Border.all(
                        color: const Color(0xFFB60F6E), width: 2),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/user.jpg',
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
                                color: Color(0xFFB60F6E),
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
                        backgroundColor: const Color(0xFFB60F6E),
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
