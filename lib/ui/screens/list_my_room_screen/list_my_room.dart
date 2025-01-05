import 'dart:typed_data';
import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flatemates_ui/controllers/room.controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';


class AddRoomPage extends StatefulWidget {
  const AddRoomPage({super.key});

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(RoomController());
    final _formKey = GlobalKey<FormState>();
    var screenWidth = MediaQuery.of(context).size.width;
    Future<void> _pickAndUploadImage(BuildContext context) async {
      if (controller.imageUrls.length >= 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You can only upload up to 3 images.")),
        );
        return;
      }

      final uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.click();

      uploadInput.onChange.listen((event) async {
        final file = uploadInput.files?.first;
        if (file == null) return;

        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);

        reader.onLoadEnd.listen((_) async {
          try {
            final fileName = 'images/${DateTime.now().millisecondsSinceEpoch}_${file.name}';
            final ref = FirebaseStorage.instance.ref(fileName);
            final uploadTask = ref.putData(reader.result as Uint8List);
            await uploadTask.whenComplete(() async {
              final url = await ref.getDownloadURL();
              controller.imageUrls.add(url);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Image uploaded successfully!")),
              );
            });
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to upload image: $e")),
            );
          }
        });
      });
    }


    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xfff8e6f1),
        iconTheme: IconThemeData(
          color: Color(0xFFB60F6E)
        ),
        title: const Text('Add Your Room Details',style: TextStyle(color: Color(0xFFB60F6E)),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 600 ? 16.0 : 40.0,
          vertical: 20.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Room Type Dropdown
              CustomDropdownField(
                label: "Room Type*",
                hintText: "Select Room Type",
                options: const ["1BHK", "2BHK", "3BHK"],
                onChanged: (value) {
                  controller.setRoomType(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a room type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomDropdownField(
                label: "Home Type*",
                hintText: "Select Home Type",
                options: const [
                  "Aprtment",
                  "Individual House",
                  "Gated Community Flat",
                  "Villa"
                ],
                onChanged: (value) {
                  controller.setHomeType(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a home type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Address TextField
              CustomTextField(
                label: "Address*",
                hintText: "Write your address...",
                onChanged: (value) {
                  controller.setAddress(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Room Rent TextField
              CustomTextField(
                label: "Room Rent*",
                hintText: "e.g. \$5000",
                onChanged: (value) {
                  controller.setRoomRent(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the room rent';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Move In Date Dropdown
              CustomDropdownField(
                label: "Move in Date",
                hintText: "Select an option",
                options: const ["Immediately", "1 Month", "3 Months"],
                onChanged: (value) {
                  controller.setMoveInDate(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a move-in date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Occupation per room Dropdown
              CustomDropdownField(
                label: "Occupation per room",
                hintText: "Select an option",
                options: const ["1 Person", "2 Persons", "3 Persons"],
                onChanged: (value) {
                  controller.setOccupationPerRoom(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the number of people per room';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              CustomTextField(
                label: "Contact Number*",
                hintText: "Enter Contect number",
                onChanged: (value) {
                  controller.setMobileNumber(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              MultiSelectDialogField(
                title: Text("Select Amenities"),
                items: [
                  MultiSelectItem("Fridge", "Fridge"),
                  MultiSelectItem("Washing Machine", "Washing Machine"),
                  MultiSelectItem("Matress", "Matress"),
                  MultiSelectItem("Smart TV", "Smart TV"),
                  MultiSelectItem("Sofa", "Sofa"),
                  MultiSelectItem("Dining table", "Dining table"),
                  MultiSelectItem("AC", "AC"),
                  MultiSelectItem("Water purifier", "Water purifier"),
                  MultiSelectItem("Geyser", "Geyser"),
                ],
                initialValue: controller.selectedValues.toList(), // Pass a list
                onConfirm: (values) {
                  controller.updateSelectedValues(values.cast<String>());
                },
              ),

              const SizedBox(height: 16),
              Obx(() => Wrap(
                spacing: 8.0,
                children: controller.imageUrls.map((url) {
                  return Image.network(url, width: 100, height: 100);
                }).toList(),
              )),
              ElevatedButton(
                onPressed: () => _pickAndUploadImage(context),
                child: Text('Upload Image'),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.submitRoomListing();  // This will now work because image upload status is tracked
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                    backgroundColor: Color(0xFFB60F6E), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final ValueChanged<String> onChanged;
  final String? initialValue; // Added for autofill functionality
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.initialValue, // Accept initial value for autofill
    this.validator,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller:
              TextEditingController(text: initialValue), // Set initial value
          onChanged: onChanged,
          validator: validator,

          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final String? selectedValue; // Added for pre-select functionality
  final String? Function(String?)? validator;


  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.options,
    required this.onChanged,
    this.selectedValue, // Accept selected value for autofill
    this.validator,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue, // Bind the selected value here
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
          ),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          validator: validator,
        ),
      ],
    );
  }
}

/*
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flatemates_ui/controllers/room.controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';

import '../room_details_screen/room_details.dart';

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({super.key});

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(RoomController());
    final _formKey = GlobalKey<FormState>();
    var screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xfff8e6f1),
        iconTheme: IconThemeData(
          color: Color(0xFFB60F6E)
        ),
        title: const Text('Add Your Room Details',style: TextStyle(color: Color(0xFFB60F6E)),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 600 ? 16.0 : 40.0,
          vertical: 20.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Room Type Dropdown
              CustomDropdownField(
                label: "Room Type*",
                hintText: "Select Room Type",
                options: const ["1BHK", "2BHK", "3BHK"],
                onChanged: (value) {
                  controller.setRoomType(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a room type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomDropdownField(
                label: "Home Type*",
                hintText: "Select Home Type",
                options: const [
                  "Aprtment",
                  "Individual House",
                  "Gated Community Flat",
                  "Villa"
                ],
                onChanged: (value) {
                  controller.setHomeType(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a home type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Address TextField
              CustomTextField(
                label: "Address*",
                hintText: "Write your address...",
                onChanged: (value) {
                  controller.setAddress(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Room Rent TextField
              CustomTextField(
                label: "Room Rent*",
                hintText: "e.g. \$5000",
                onChanged: (value) {
                  controller.setRoomRent(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the room rent';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Move In Date Dropdown
              CustomDropdownField(
                label: "Move in Date",
                hintText: "Select an option",
                options: const ["Immediately", "1 Month", "3 Months"],
                onChanged: (value) {
                  controller.setMoveInDate(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a move-in date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Occupation per room Dropdown
              CustomDropdownField(
                label: "Occupation per room",
                hintText: "Select an option",
                options: const ["1 Person", "2 Persons", "3 Persons"],
                onChanged: (value) {
                  controller.setOccupationPerRoom(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the number of people per room';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              CustomTextField(
                label: "Contact Number*",
                hintText: "Enter Contect number",
                onChanged: (value) {
                  controller.setMobileNumber(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              MultiSelectDialogField(
                title: Text("Select Amenities"),
                items: [
                  MultiSelectItem("Fridge", "Fridge"),
                  MultiSelectItem("Washing Machine", "Washing Machine"),
                  MultiSelectItem("Matress", "Matress"),
                  MultiSelectItem("Smart TV", "Smart TV"),
                  MultiSelectItem("Sofa", "Sofa"),
                  MultiSelectItem("Dining table", "Dining table"),
                  MultiSelectItem("AC", "AC"),
                  MultiSelectItem("Water purifier", "Water purifier"),
                  MultiSelectItem("Geyser", "Geyser"),
                ],
                initialValue: controller.selectedValues.toList(), // Pass a list
                onConfirm: (values) {
                  controller.updateSelectedValues(values.cast<String>());
                },
              ),


              const SizedBox(height: 16),

              // Upload Images Section
              // const Text(
              //   "Upload at least 3 images*",
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 8),
              // Obx(() {
              //   return Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: List.generate(3, (index) {
              //       return GestureDetector(
              //         onTap: () {
              //           // Open image picker here, and then call controller.addProfileImage(imageUrl);
              //         },
              //         child: Container(
              //           height: 80,
              //           width: 80,
              //           decoration: BoxDecoration(
              //             color: Colors.grey[300],
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           child: Icon(Icons.add_a_photo, color: Colors.grey[700]),
              //         ),
              //       );
              //     }),
              //   );
              // }),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.submitRoomListing();  // This will now work because image upload status is tracked
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                    backgroundColor: Color(0xFFB60F6E), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final ValueChanged<String> onChanged;
  final String? initialValue; // Added for autofill functionality
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.initialValue, // Accept initial value for autofill
    this.validator,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller:
              TextEditingController(text: initialValue), // Set initial value
          onChanged: onChanged,
          validator: validator,

          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final String? selectedValue; // Added for pre-select functionality
  final String? Function(String?)? validator;


  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.options,
    required this.onChanged,
    this.selectedValue, // Accept selected value for autofill
    this.validator,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue, // Bind the selected value here
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
          ),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          validator: validator,
        ),
      ],
    );
  }
}*/