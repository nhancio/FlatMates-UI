import 'dart:io';
import 'package:flatmates/controllers/auth_controller.dart';
import 'package:flatmates/screen/flate_mates.dart';
import 'package:flatmates/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:flatmates/widgets/custom_button.dart';
import 'package:flatmates/widgets/custom_text_field.dart';

class UserInformationScreen extends StatefulWidget {
  @override
  _UserInformationScreenState createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final TextEditingController genderController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController foodChoiceController = TextEditingController();
  final TextEditingController drinkingController = TextEditingController();
  final TextEditingController smokingController = TextEditingController();
  final TextEditingController petController = TextEditingController();

  final List<XFile?> _imageFiles = List<XFile?>.filled(3, null);
  final ImagePicker _picker = ImagePicker();
  String? selectedFoodPreference;
  String? selectedGender;
  bool? drinkingValue;
  bool? petValue;
  bool? smokingValue;

  Future<void> _pickImage(int index) async {
    final XFile? selectedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (selectedImage != null) {
      setState(() {
        _imageFiles[index] = selectedImage;
      });
    }
  }

   final AuthController authController =
      Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 25,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,size: 18,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.lightBackground // Use centralized color
                : AppColors.darkBackground, // Use centralized color
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Information',
                style: AppTextStyles.titleStyle(context),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.person,
                label: 'Name',
                controller: nameController,
                hintText: 'Name',
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: CustomStyledDropdown(
                  selectedValue: selectedGender,
                  items: const ['Male', 'Female', 'Other'],
                  hintText: 'Select Gender',
                  icon: Icons.person,
                  label: 'Gender',
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  isDarkMode: true,
                ),
              ),
              const SizedBox(height: 10),

              CustomTextField(
                icon: Icons.cake,
                label: 'Your Age',
                controller: ageController,
                hintText: '25',
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: CustomStyledDropdown(
                  selectedValue: selectedFoodPreference,
                  items: ['Veg', 'Non-Veg'],
                  hintText: 'Select Food Preference',
                  icon: Icons.fastfood,
                  label: 'Food Preference',
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFoodPreference = newValue;
                    });
                  },
                  isDarkMode: true,
                ),
              ),
              const SizedBox(height: 10),
              // CustomTextField(
              //   icon: Icons.restaurant,
              //   label: 'Food Choice',
              //   controller: foodChoiceController,
              //   hintText: 'Veg',
              // ),
                          const SizedBox(height: 10),
             SizedBox(
              height: 60,
               child: CustomBooleanDropdown(
                icon: Icons.local_drink,
                label: 'Drinking',
                hintText: 'Sometimes',
                selectedValue: drinkingValue,
                onChanged: (bool? newValue) {
                  setState(() {
                    drinkingValue = newValue ?? false;
                  });
                },
                isDarkMode: true,
                           ),
             ),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              child: CustomBooleanDropdown(
                icon: Icons.smoking_rooms,
                label: 'Smoking',
                hintText: 'No',
                selectedValue: smokingValue,
                onChanged: (bool? newValue) {
                  setState(() {
                    smokingValue = newValue;
                  });
                },
                isDarkMode: true,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              child: CustomBooleanDropdown(
                icon: Icons.pets,
                label: 'Pet',
                hintText: 'No',
                selectedValue: petValue,
                onChanged: (bool? newValue) {
                  setState(() {
                    petValue = newValue;
                  });
                },
                isDarkMode: true,
              ),
            ),
              const SizedBox(height: 20),
              Text(
                'Upload at least 3 images',
                style: AppTextStyles.bodyStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return GestureDetector(
                    onTap: () => _pickImage(index),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.lightBackground,
                        border: Border.all(
                          color: AppColors.lightChipBackground,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: _imageFiles[index] == null
                          ? const Center(
                              child: Icon(
                                Icons.add_photo_alternate,
                                color: AppColors.darkChipBackground,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                File(_imageFiles[index]!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
               Center(
                child: Obx(
                  () => authController.isLoading.value
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: 'Done',
                          onPressed: () {
                            authController.submitUserInformation(
                               phone: authController.phone,
                              name: nameController.text,
                              gender: selectedGender ?? '',
                              age:int.parse(ageController.text),
                              foodPreference:
                                  selectedFoodPreference ?? 'Veg',
                              drinking: drinkingValue ?? false,
                              smoking: smokingValue ?? false,
                              pet: petValue ?? false,
                              imagePaths: _imageFiles
                                  .where((file) => file != null)
                                  .map((file) => file!.path)
                                  .toList(),
                            );
                          },
                        ),
                ),),
            ],
          ),
        ),
      ),
    );
  }
}
