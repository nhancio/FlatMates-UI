import 'dart:io';
import 'package:flatemates_ui/Jay/navigation/app_routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flatemates_ui/Jay/res/colors/colors.dart';
import 'package:flatemates_ui/Jay/res/font/text_style.dart';
import 'package:flatemates_ui/Jay/widgets/custom_button/custom_button.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

class RegisterUserScreen extends StatefulWidget {
  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String? selectedGender;
  String? selectedProfession; // Added profession selection variable
  File? profileImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

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
                      height: MediaQuery.of(context).size.height > 600 ? 60 : 100,
                    ),
                    Image.asset(
                      'assets/icons/icon.png',
                      height: 80,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Register Yourself',
                      style: AppTextStyles.largeTitleStyle(context).copyWith(
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
                          controller: nameController,
                          labelText: 'Your Name*',
                          width: isWideScreen ? constraints.maxWidth * 0.45 : double.infinity,
                        ),
                        _buildProfessionDropdown(
                          context: context,
                          labelText: 'Profession',
                          width: isWideScreen ? constraints.maxWidth * 0.45 : double.infinity,
                        ),
                        _buildDropdown(
                          context: context,
                          labelText: 'Your gender*',
                          width: isWideScreen ? constraints.maxWidth * 0.45 : double.infinity,
                        ),
                        _buildTextField(
                          controller: ageController,
                          labelText: 'Age',
                          keyboardType: TextInputType.number,
                          width: isWideScreen ? constraints.maxWidth * 0.45 : double.infinity,
                          isAgeField: true, // Specify that this is the age field
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Column(
                      children: [
                        Text(
                          'Upload your profile picture*',
                          style: AppTextStyles.bodyStyle(context).copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: profileImage != null ? FileImage(profileImage!) : null,
                            child: profileImage == null
                                ? Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.grey[800],
                            )
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    CustomButton(
                      text: 'Register Your Account',
                      onPressed: () {
                        if (_validateForm()) {
                          Get.toNamed(AppRoutes.preferences);
                        }
                      },
                    ),
                    const SizedBox(height: 15),

                    Text.rich(
                      TextSpan(
                        text: 'By registering with us, you are agreeing with our ',
                        style: AppTextStyles.bodyStyle(context).copyWith(
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms & Condition',
                            style: AppTextStyles.bodyStyle(context).copyWith(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ', '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AppTextStyles.bodyStyle(context).copyWith(
                              fontSize: 14,
                              color: AppColors.primaryColor,
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
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (isAgeField && value.length > 2) {
            controller.text = value.substring(0, 2); // Limit to two digits
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
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        hint: Text('Gender'),
        items: ['Male', 'Female', 'Other']
            .map((gender) => DropdownMenuItem(
          value: gender,
          child: Text(gender),
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedGender = value;
          });
        },
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildProfessionDropdown({
    required BuildContext context,
    required String labelText,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: DropdownButtonFormField<String>(
        value: selectedProfession,
        hint: Text('Select Profession'),
        items: ['IT', 'Medicine', 'Student', 'Seeking Job', 'Content Creator', 'Others']
            .map((profession) => DropdownMenuItem(
          value: profession,
          child: Text(profession),
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedProfession = value;
          });
        },
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  bool _validateForm() {
    if (nameController.text.isEmpty ||
        selectedGender == null ||
        selectedProfession == null ||
        ageController.text.isEmpty ||
        profileImage == null) {
      Get.snackbar('Error', 'Please fill all required fields and upload your profile picture.');
      return false;
    }
    return true;
  }
}

