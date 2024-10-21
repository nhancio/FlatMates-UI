/*
import 'package:flatmates/controllers/bottom_bar_controller.dart';
import 'package:flatmates/screen/details_screen/flate_mate_details.dart';
import 'package:flatmates/screen/search_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX for navigation

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller for managing the search bar text
  final TextEditingController _searchController = TextEditingController();

  void changeToProfileTab() {
  BottomNavController controller = Get.find();
  controller.changeTabIndex(2); // Change to the Profile tab
}

  // Sample data for flatmates in Hyderabad
  final List<Map<String, String>> hyderabadFlatmates = [
    {
      "name": "Daniel, 26",
      "details": "Artist, 80% Matched",
      "image": "assets/images/daniel.png",
    },
    {
      "name": "Laura, 24",
      "details": "Engineer, 75% Matched",
      "image": "assets/images/laura.png",
    },
    // Add more flatmates here
  ];

  @override
  Widget build(BuildContext context) {
    // Determine the current theme mode
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color:
                        isDarkMode ? Colors.pink.shade900 : Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Trusted & loved by million users",
                    style: TextStyle(
                      color: isDarkMode ? Colors.pink.shade100 : Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Find compatible flatmates",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Rooms & PGs",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Share your room with the right roommates",
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.grey.shade800
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on,
                          color: isDarkMode ? Colors.white : Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onSubmitted: (value) {
                            // if (value.toLowerCase() == "hyderabad") {
                            Get.to(
                              () =>
                                  Search_details(), */
/*rguments: {
                                "location": "Hyderabad",
                                "flatmates": hyderabadFlatmates,0
                              }*//*

                            );
                            // }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Places...',
                            hintStyle: TextStyle(
                              color: isDarkMode ? Colors.white70 : Colors.grey,
                            ),
                          ),
                          style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top Cities:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 16.0,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchController.text = "Bangalore";
                        });
                      },
                      child: Text(
                        "Bangalore",
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              isDarkMode ? Colors.blue.shade200 : Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchController.text = "Hyderabad";
                        });
                      },
                      child: Text(
                        "Hyderabad",
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              isDarkMode ? Colors.blue.shade200 : Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchController.text = "Pune";
                        });
                      },
                      child: Text(
                        "Pune",
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              isDarkMode ? Colors.blue.shade200 : Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                    backgroundColor:
                        isDarkMode ? Colors.pink.shade900 : Colors.pink.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 2, // Adjust elevation as needed
                  ),
                  onPressed: () {
                     changeToProfileTab();
                  },
                  child: Text(
                    "Search",
                    style: TextStyle(
                      color: isDarkMode ? Colors.pink.shade100 : Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/home_room.png', // replace with your illustration path
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  "You are the average of the three people you spend the most time with. Let AI help you find the best ones!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  "Train the AI model with your preferences and get the perfect flatmate.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
