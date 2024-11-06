import 'package:flutter/material.dart';

class ProfileIntroScreen extends StatelessWidget {
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController foodChoiceController = TextEditingController();
  final TextEditingController drinkingController = TextEditingController();
  final TextEditingController smokingController = TextEditingController();
  final TextEditingController petController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.purple, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/icons/danile.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Danial Dan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Male | 0987654321',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // About You Section
              _buildTextField('Gender', genderController),
              _buildTextField('Age', ageController),
              _buildTextField('Location', locationController),
              _buildTextField('Food Choice', foodChoiceController),
              _buildTextField('Drinking', drinkingController),
              _buildTextField('Smoking', smokingController),
              _buildTextField('Pet', petController),

              SizedBox(height: 20),

              // Preferences Section
              Text(
                'Preference',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildPreferenceRow(),
              SizedBox(height: 20),

              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save action, like saving the user's input data
                  },
                  child: Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceRow() {
    List<Map<String, String>> preferences = [
      {'title': 'Non-Smoker', 'icon': 'assets/icons/non_smoker.png'},
      {'title': 'Travel Person', 'icon': 'assets/icons/travel.png'},
      {'title': 'Studious', 'icon': 'assets/icons/studious.png'},
      {'title': 'Yoga Person', 'icon': 'assets/icons/yoga.png'},
      {'title': 'Music Person', 'icon': 'assets/icons/music.png'},
      {'title': 'Non-Alcoholic', 'icon': 'assets/icons/alcoholic.png'},
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: preferences.map((pref) {
        return Column(
          children: [
            Image.asset(
              pref['icon']!,
              height: 60,
              width: 60,
            ),
            SizedBox(height: 4),
            Text(
              pref['title']!,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        );
      }).toList(),
    );
  }
}
