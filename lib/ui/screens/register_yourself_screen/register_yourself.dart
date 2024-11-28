import 'package:flatemates_ui/controllers/register.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart';

// For kIsWeb

class RegisterUserScreen extends StatelessWidget {
  final RegisterUserController controller = Get.put(RegisterUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: double.infinity,
                height: kIsWeb ? MediaQuery.of(context).size.height : null,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height:
                          MediaQuery.of(context).size.height > 600 ? 60 : 100,
                    ),
                    Image.asset(
                      'assets/icons/icon.png',
                      height: 80,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Register Yourself',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildTextField(
                          controller: controller.nameController,
                          labelText: 'Your Name*',
                          width: isWideScreen
                              ? constraints.maxWidth * 0.45
                              : double.infinity,
                        ),
                        _buildTextField(
                          controller: controller.phoneController,
                          labelText: 'Phone number*',
                          width: isWideScreen
                              ? constraints.maxWidth * 0.45
                              : double.infinity,
                        ),
                        _buildProfessionDropdown(
                          context: context,
                          labelText: 'Profession',
                          width: isWideScreen
                              ? constraints.maxWidth * 0.45
                              : double.infinity,
                        ),
                        _buildDropdown(
                          context: context,
                          labelText: 'Your Gender*',
                          width: isWideScreen
                              ? constraints.maxWidth * 0.45
                              : double.infinity,
                        ),
                        _buildTextField(
                          controller: controller.ageController,
                          labelText: 'Age',
                          keyboardType: TextInputType.number,
                          width: isWideScreen
                              ? constraints.maxWidth * 0.45
                              : double.infinity,
                          isAgeField: true,
                        ),
                      ],
                    ),
                    // const SizedBox(height: 20),
                    // Column(
                    //   children: [
                    //     const Text(
                    //       'Upload your profile picture*',
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     const SizedBox(height: 10),
                    //     GestureDetector(
                    //       onTap: controller.pickImage,
                    //       child: Obx(() {
                    //         return CircleAvatar(
                    //           radius: 40,
                    //           backgroundColor: Colors.grey[300],
                    //           backgroundImage: controller.profileImage.value !=
                    //                   null
                    //               ? FileImage(controller.profileImage.value!)
                    //               : null,
                    //           child: controller.profileImage.value == null
                    //               ? Icon(
                    //                   Icons.camera_alt,
                    //                   size: 30,
                    //                   color: Colors.grey[800],
                    //                 )
                    //               : null,
                    //         );
                    //       }),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.validateForm()) {
                          controller.addUserToFirestore(
                              userName: controller.nameController.text,
                              userEmail: controller.emailController.text,
                              userPhoneNumber: controller.phoneController.text,
                              profession: controller.selectedProfession.value,
                              gender: controller.selectedGender.value,
                              ageText: controller.ageController.text,
                              profileImage: controller.profileImage.value);
                          Get.toNamed(
                              '/preferences'); // Navigate using GetX route
                        }
                      },
                      child: const Text('Register Your Account'),
                    ),
                    const SizedBox(height: 15),
                    const Text.rich(
                      TextSpan(
                        text:
                            'By registering with us, you are agreeing with our ',
                        style: TextStyle(fontSize: 14),
                        children: [
                          TextSpan(
                            text: 'Terms & Condition',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ', '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required double width,
    bool isAgeField = false,
  }) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: isAgeField
            ? [FilteringTextInputFormatter.digitsOnly] // Only allow digits
            : [],
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (isAgeField && value.length > 3) {
            controller.text = value.substring(0, 3); // Limit to three digits
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
          }
        },
      ),
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String labelText,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: Obx(() {
        return DropdownButtonFormField<String>(
          value: controller.selectedGender.value,
          hint: const Text('Gender'),
          items: ['Male', 'Female', 'Other']
              .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  ))
              .toList(),
          onChanged: (value) {
            controller.selectedGender.value = value!;
          },
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
        );
      }),
    );
  }

  Widget _buildProfessionDropdown({
    required BuildContext context,
    required String labelText,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: Obx(() {
        return DropdownButtonFormField<String>(
          value: controller.selectedProfession.value,
          hint: const Text('Select Profession'),
          items: [
            'IT',
            'Medicine',
            'Student',
            'Seeking Job',
            'Content Creator',
            'Others'
          ]
              .map((profession) => DropdownMenuItem(
                    value: profession,
                    child: Text(profession),
                  ))
              .toList(),
          onChanged: (value) {
            controller.selectedProfession.value = value!;
          },
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
        );
      }),
    );
  }
}
