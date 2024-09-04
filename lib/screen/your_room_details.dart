import 'dart:io';
import 'package:flatmates/controllers/room_controller.dart';
import 'package:flatmates/screen/flate_mates.dart';
import 'package:flatmates/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:flatmates/widgets/custom_button.dart';
import 'package:flatmates/widgets/custom_text_field.dart';

class YourRoomDetails extends StatefulWidget {
  @override
  _YourRoomDetailsState createState() => _YourRoomDetailsState();
}

class _YourRoomDetailsState extends State<YourRoomDetails> {
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController foodChoiceController = TextEditingController();
  final TextEditingController drinkingController = TextEditingController();
  final TextEditingController roomRentController = TextEditingController();
  final TextEditingController smokingController = TextEditingController();
  final TextEditingController petController = TextEditingController();
  bool? isRoomAvailable;
  String? selectedRoomType;
  String? selectedBuildingType;

  final roomCtrl = Get.put(RoomController());

  List<XFile?> _imageFiles = List<XFile?>.filled(3, null);
  final ImagePicker _picker = ImagePicker();

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

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
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
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Your room details',
                        style: AppTextStyles.titleStyle(context),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Is Room Available?",
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Switch(
                        value: isRoomAvailable ?? false,
                        activeColor: Colors.purpleAccent,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                        onChanged: (value) {
                          setState(() {
                            isRoomAvailable = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                icon: Icons.person,
                label: 'Enter your location.....',
                controller: locationController,
                hintText: 'Your Location',
              ),
              CustomTextField(
                icon: Icons.money,
                label: 'Room Rent',
                controller: roomRentController,
                hintText: '5000',
              ),
               const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: CustomStyledDropdown(
                  selectedValue: selectedRoomType,
                  items: ['1RK', '2BHK','1BHK','3BHK'],
                  hintText: 'Select Room Type',
                  icon: Icons.door_front_door_rounded,
                  label: 'Room Type',
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRoomType = newValue;
                    });
                  },
                  isDarkMode: true,
                ),
              ),
              const SizedBox(height: 20),  
              SizedBox(
                height: 60,
                child: CustomStyledDropdown(
                  selectedValue: selectedBuildingType,
                  items: ['Individual', 'Apartment','Villa'],
                  hintText: 'Select Building Type',
                  icon: Icons.business,
                  label: 'Building Type',
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBuildingType = newValue;
                    });
                  },
                  isDarkMode: true,
                ),
              ),
              const SizedBox(height: 10),
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
                child: Obx(() {
                  if (roomCtrl.isLoading.value) {
                    return CircularProgressIndicator();
                  } else {
                    return CustomButton(
                      text: 'Submit',
                      onPressed: () {
                        // Submit room details
                        if (locationController.text.isNotEmpty &&
                            roomRentController.text.isNotEmpty &&
                            selectedRoomType != null &&
                            selectedBuildingType != null) {
                          roomCtrl.addRoomDetails(
                            location: locationController.text,
                            rent: int.parse(roomRentController.text),
                            roomType: selectedRoomType!,
                            buildingType: selectedBuildingType!,
                            isRoomAvailable: isRoomAvailable ?? false,
                          );
                        } else {
                          Get.snackbar('Error', 'Please fill all fields');
                        }
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
