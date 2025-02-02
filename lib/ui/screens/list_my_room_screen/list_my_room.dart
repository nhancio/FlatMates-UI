import 'dart:typed_data';
import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flatemates_ui/controllers/room.controller.dart';
import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    bool isLoading = false; // Flag to track loading state

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

    final TextEditingController addressController = TextEditingController();
    final TextEditingController rentController = TextEditingController();
    final TextEditingController contactController = TextEditingController();

    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation,
                    secondaryAnimation) =>
                    BottomNavBarScreen(),
                transitionsBuilder: (context, animation,
                    secondaryAnimation, child) {
                  var tween = Tween(
                      begin: const Offset(0.0, 0.0),
                      end: Offset.zero)
                      .chain(
                      CurveTween(curve: Curves.ease));
                  var offsetAnimation =
                  animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },),);
          },
        ),
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
              // Address TextField
              CustomTextField(
                controller: addressController,
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
                isContactNumber: false,
              ),
              const SizedBox(height: 12),
              // Room Rent TextField
              CustomTextField(
                controller: rentController,
                label: "Room Rent*",
                hintText: "e.g. \₹5000",
                onChanged: (value) {
                  controller.setRoomRent(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the room rent';
                  }
                  return null;
                },
                isContactNumber: true,
              ),
              const SizedBox(height: 12),

              CustomTextField(
                controller: contactController,
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
                isContactNumber: true,
              ),
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
                  "Apartment",
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
                label: "Occupancy per room",
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
              Text(
                "Select Amenities",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
            MultiSelectDialogField(

              backgroundColor: Colors.white,
              title: const Text(
                "Select Amenities",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              items:  [
                MultiSelectItem("Fridge", "Fridge"),
                MultiSelectItem("Washing Machine", "Washing Machine"),
                MultiSelectItem("Mattress", "Mattress"),
                MultiSelectItem("Smart TV", "Smart TV"),
                MultiSelectItem("Sofa", "Sofa"),
                MultiSelectItem("Dining Table", "Dining Table"),
                MultiSelectItem("AC", "AC"),
                MultiSelectItem("Water Purifier", "Water Purifier"),
                MultiSelectItem("Geyser", "Geyser"),
              ],
              initialValue: controller.selectedValues.toList(),
              onConfirm: (values) {
                controller.updateSelectedValues(values.cast<String>());
              },
              buttonText: const Text(
                "Select Amenities",
                style: TextStyle(
                  fontSize: 16,

                  color: Color(0xff949292),
                ),
              ),
              buttonIcon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              dialogHeight: 400, // Adjust height
              dialogWidth: 300, // Adjust width

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
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  backgroundColor: Colors.blue.shade200
                ),
                child: Text('Upload Image',style: TextStyle(color: Colors.white),),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async{
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      controller.submitRoomListing();
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation,
                              secondaryAnimation) =>
                              RoomList(),
                          transitionsBuilder: (context, animation,
                              secondaryAnimation, child) {
                            var tween = Tween(
                                begin: const Offset(0.0, 0.0),
                                end: Offset.zero)
                                .chain(
                                CurveTween(curve: Curves.ease));
                            var offsetAnimation =
                            animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },),);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
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
  final bool isContactNumber;
  final TextEditingController? controller; // Accept controller

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.initialValue, // Accept initial value for autofill
    this.validator,
    this.isContactNumber = false,
    this.controller,
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
          controller, // Set initial value
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey, // Border color when not focused
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFFB60F6E), // Border color when focused or selected
              ),
            ),
          ),
          keyboardType: isContactNumber ? TextInputType.phone : TextInputType.text,  // Change keyboard type
          inputFormatters: isContactNumber
              ? [
            FilteringTextInputFormatter.digitsOnly,  // Allow only digits for contact number
            LengthLimitingTextInputFormatter(10),    // Limit to 10 digits
          ]
              : null,  // No restrictions for address

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

         // value: selectedValue, // Bind the selected value here
          value: options.contains(selectedValue) ? selectedValue : null,
          dropdownColor: Colors.white,
          hint: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              hintText,
              style: const TextStyle(


              ),
              overflow: TextOverflow.visible,
            ),
          ),

          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          //hintText: hintText,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey, // Border color when not focused
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFFB60F6E), // Border color when focused or selected
              ),
            ),
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

