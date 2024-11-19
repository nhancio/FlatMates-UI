import 'package:flutter/material.dart';

class RoomListingPage extends StatelessWidget {
  const RoomListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Room Details'),
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
            const CustomTextField(
                label: "Your Name*", hintText: "Enter your name"),
            const SizedBox(height: 20),
            const CustomDropdownField(
              label: "Room Type*",
              hintText: "Select Room Type",
              options: ["1BHK", "2BHK", "3BHK"],
            ),
            const SizedBox(height: 20),
            const CustomTextField(
                label: "Address*", hintText: "Write your address..."),
            const SizedBox(height: 20),
            const CustomTextField(label: "Room Rent*", hintText: "e.g. \$5000"),
            const SizedBox(height: 20),
            const CustomDropdownField(
              label: "Move in Date",
              hintText: "Select an option",
              options: ["Immediately", "1 Month", "3 Months"],
            ),
            const SizedBox(height: 20),
            const CustomDropdownField(
              label: "Occupation per room",
              hintText: "Select an option",
              options: ["1 Person", "2 Persons", "3 Persons"],
            ),
            const SizedBox(height: 20),
            const CustomDropdownField(
              label: "Looking For",
              hintText: "Select an option",
              options: ["Roommate", "Room"],
            ),
            const SizedBox(height: 20),
            const CustomDropdownField(
              label: "Pet",
              hintText: "Select an option",
              options: ["Yes", "No"],
            ),
            const SizedBox(height: 20),
            const Text(
              "Upload at least 3 images*",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                return Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.add_a_photo, color: Colors.grey[700]),
                );
              }),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  backgroundColor: Colors.pink, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
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
        const SizedBox(height: 8),
        TextField(
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

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.options,
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
        const SizedBox(height: 8),
        DropdownButtonFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
          ),
          items: options.map((option) {
            return DropdownMenuItem(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
