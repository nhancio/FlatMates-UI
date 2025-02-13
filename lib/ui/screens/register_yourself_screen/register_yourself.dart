import 'package:flatemates_ui/controllers/register.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart';

// For kIsWeb

class RegisterUserScreen extends StatelessWidget {
  final RegisterUserController controller = Get.put(RegisterUserController());
  String? phoneError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return Center(
            child: Container(
              width: double.infinity,
              height: kIsWeb ? MediaQuery.of(context).size.height : null,
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  /*  SizedBox(
                      height:
                          MediaQuery.of(context).size.height > 600 ? 60 : 1,
                    ),*/
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
                      /*  _buildTextField(

                          controller: controller.phoneController,
                          labelText: 'Phone number*',
                          keyboardType: TextInputType.number,
                          width: isWideScreen ? constraints.maxWidth * 0.45 : double.infinity,
                          isPhoneField: true,
                          errorText: phoneError, // Pass the error message here
                        ),
*/
                        _buildTextFieldPhone(
                          context: context,
                          controller: controller.phoneController,
                          labelText: 'Phone number*',
                          keyboardType: TextInputType.number,
                          width: isWideScreen ? constraints.maxWidth * 0.45 : double.infinity,
                          isPhoneField: true,
                          errorText: phoneError,
                        ),


                        _buildProfessionDropdown(
                          context: context,
                          labelText: 'Profession*',
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
                        _buildTextFieldAge(
                          controller: controller.ageController,
                          labelText: 'Age*',
                          keyboardType: TextInputType.number,
                          width: isWideScreen
                              ? constraints.maxWidth * 0.45
                              : double.infinity,
                          isAgeField: true, // Age-specific validation
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFB60F6E),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Increase padding for bigger button

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                    ),
                      child: const Text('Register Your Account',style: TextStyle(color: Colors.white),),
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
    bool isPhoneField = false, // Flag for phone validation
    String? errorText, // Error text to show when the phone number is invalid
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: isPhoneField
                ? [FilteringTextInputFormatter.digitsOnly] // Only allow digits for phone number
                : [],
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(),
              errorText: errorText, // Display error message if any
            ),
            onChanged: (value) {
              if (isPhoneField) {
                // Ensure the phone number has exactly 10 digits
                if (value.length > 10) {
                  controller.text = value.substring(0, 10); // Limit to 10 digits
                  controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: controller.text.length)); // Move the cursor to the end
                }
              }
            },
          ),
        ),
        if (errorText != null && errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }


  Widget _buildTextFieldAge({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required double width,
    bool isAgeField = false, // Flag for age-specific validation
  }) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: isAgeField
            ? [FilteringTextInputFormatter.digitsOnly] // Only allow digits for age
            : [],
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (isAgeField) {
            // Make sure the value is a valid number and not empty
            if (value.isNotEmpty && int.tryParse(value) != null) {
              int age = int.parse(value);
              // Check if the age is within a valid range (between 1 and 99)
              if (age < 1 || age > 99) {
                // If age is not in range, reset the input or display a message
                controller.text = '';
              }
            } else {
              // If it's not a valid number, reset the input
              controller.text = '';
            }

            // Move the cursor to the end after text change
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
          dropdownColor: Colors.white,
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
          dropdownColor: Colors.white,


          itemHeight: 50.0,
          menuMaxHeight: 200.0,
        );
      }),
    );
  }

  Widget _buildTextFieldPhone({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    required double width,
    bool isPhoneField = false, // Flag for phone validation
    String? errorText, // Error text to show when the phone number is invalid
    required BuildContext context, // Add context for SnackBar
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: isPhoneField
                ? [FilteringTextInputFormatter.digitsOnly] // Only allow digits for phone number
                : [],
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(),
              errorText: errorText, // Display error message if any
            ),
            onChanged: (value) {
              if (isPhoneField) {
                // Limit input to 10 digits
                if (value.length > 10) {
                  controller.text = value.substring(0, 10);
                  controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: controller.text.length));
                }

                // Validate if the number starts with 9, 8, 7, or 6
                if (value.isNotEmpty && !RegExp(r'^[9876]\d*$').hasMatch(value)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Contact number must start with 9, 8, 7, or 6"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
          ),
        ),
        if (errorText != null && errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

}
