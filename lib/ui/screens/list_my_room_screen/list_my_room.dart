import 'package:flatemates_ui/controllers/room.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoomPage extends StatelessWidget {
  const AddRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(RoomController());

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
            ),
            const SizedBox(height: 12),
            // Address TextField
            CustomTextField(
              label: "Address*",
              hintText: "Write your address...",
              onChanged: (value) {
                controller.setAddress(value);
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
            ),
            const SizedBox(height: 12),

            CustomTextField(
              label: "Contact Number*",
              hintText: "Enter Contect number",
              onChanged: (value) {
                controller.setMobileNumber(value);
              },
            ),
            const SizedBox(height: 12),
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
                  controller.submitRoomListing();
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
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final ValueChanged<String> onChanged;
  final String? initialValue; // Added for autofill functionality

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.initialValue, // Accept initial value for autofill
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
        TextField(
          controller:
              TextEditingController(text: initialValue), // Set initial value
          onChanged: onChanged,
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

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.options,
    required this.onChanged,
    this.selectedValue, // Accept selected value for autofill
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
        ),
      ],
    );
  }
}
