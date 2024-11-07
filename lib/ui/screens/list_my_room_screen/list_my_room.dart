import 'package:flutter/material.dart';

class RoomListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Room Details'),
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
            CustomTextField(label: "Your Name*", hintText: "Enter your name"),
            SizedBox(height: 20),
            CustomDropdownField(
              label: "Room Type*",
              hintText: "Select Room Type",
              options: ["1BHK", "2BHK", "3BHK"],
            ),
            SizedBox(height: 20),
            CustomTextField(label: "Address*", hintText: "Write your address..."),
            SizedBox(height: 20),
            CustomTextField(label: "Room Rent*", hintText: "e.g. \$5000"),
            SizedBox(height: 20),
            CustomDropdownField(
              label: "Move in Date",
              hintText: "Select an option",
              options: ["Immediately", "1 Month", "3 Months"],
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              label: "Occupation per room",
              hintText: "Select an option",
              options: ["1 Person", "2 Persons", "3 Persons"],
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              label: "Looking For",
              hintText: "Select an option",
              options: ["Roommate", "Room"],
            ),
            SizedBox(height: 20),
            CustomDropdownField(
              label: "Pet",
              hintText: "Select an option",
              options: ["Yes", "No"],
            ),
            SizedBox(height: 20),
            Text(
              "Upload at least 3 images*",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
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
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80), backgroundColor: Colors.pink, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
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
    Key? key,
    required this.label,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
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
    Key? key,
    required this.label,
    required this.hintText,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
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
