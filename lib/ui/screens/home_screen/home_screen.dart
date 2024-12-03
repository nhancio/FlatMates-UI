import 'package:flatemates_ui/controllers/bottomnav.controller.dart';
import 'package:flatemates_ui/controllers/tab.controller.dart';
import 'package:flatemates_ui/ui/screens/list_my_room_screen/list_my_room.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/assets/images/images.dart';
import '../../../res/colors/colors.dart';

class HomePage extends StatefulWidget {
  static const String firstScreen = "assets/images/first_page.png";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCity;
  BottomNavController bottomNavController = Get.put(BottomNavController());
  TabControllerState tabCtrl = Get.put(TabControllerState());

  final List<String> cities = [
    'Hitech City, Hyderabad',
    'Kondapur, Hyderabad',
    'Marathahalli, Bangalore',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;
          return Stack(
            children: [
              // Background Image
              Positioned(
                child: Image.asset(
                  Images.firstScreen,
                  fit: BoxFit.cover,
                  height:
                      MediaQuery.of(context).size.height, // Full screen height
                  width: MediaQuery.of(context).size.width, // Full screen width
                ),
              ),
              // Foreground Content with Gradient Overlay for better readability
              Positioned.fill(
                child: Container(
                  color: AppColors.backgroundOpacity.withOpacity(1),
                ),
              ),
              // Main Content
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWideScreen ? 100.0 : 20.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Hi Daniel',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB60F6E),
                            ),
                          ),
                          /*Stack(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.notifications,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                onPressed: () {
                                  // Handle notifications button press
                                },
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '5', // Display the number of notifications here
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),*/
                        ],
                      ),
                      const Text(
                        "Let's Find Peace For You!",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Search Bar with city dropdown
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),

                          border: Border.all(color: Colors.grey.withOpacity(0.5)), // Adding border

                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search),
                            const SizedBox(width: 10),
                            Expanded(
                              child: DropdownButton<String>(
                                hint: const Text('Select City'),
                                value: selectedCity,
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCity = newValue;
                                  });
                                },
                                items: cities.map<DropdownMenuItem<String>>(
                                    (String city) {
                                  return DropdownMenuItem<String>(
                                    value: city,
                                    child: Text(city),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height > 600 ? 60 : 100,
                      ),
                      Column(
                        children: [
                          // Row with two boxes
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // First box with image size
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                              body: HomemateList(),
                                              appBar: AppBar(
                                                title: const Text(
                                                    "Homemates for you"),
                                              ),
                                            )),
                                  );
                                  // tabCtrl.tabController.index = 0;
                                  // bottomNavController.setIndex(
                                  //     2); // For example, to navigate to the 'Saved' screen

                                  // _showBottomSheet(context, 'HomemateList');
                                },
                                child: _buildServiceCard(
                                  'assets/images/look_roommate.png',
                                  160.0, // Width of the box
                                  160.0, // Height of the image
                                ),
                              ),
                              // Second box with image size
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                              body: RoomList(),
                                              appBar: AppBar(
                                                title:
                                                    const Text("Rooms for you"),
                                              ),
                                            )),
                                  );
                                  // bottomNavController.setIndex(2);
                                  // tabCtrl.tabController.index = 1;
                                  // _showBottomSheet(context, 'RoomList');
                                },
                                child: _buildServiceCard(
                                  'assets/images/look_room.png',
                                  160.0, // Width of the box
                                  160.0, // Height of the image
                                ),
                              ),
                            ],
                          ),
                          // Third box with image size (in a separate column to avoid overflow)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddRoomPage(),
                                ),
                              );
                            },
                            child: _buildServiceCard(
                              'assets/images/list_room.png',
                              160.0, // Width of the box
                              160.0, // Height of the image
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String listType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows flexible height
      backgroundColor: Colors.transparent, // To make the background transparent
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0), // Adjust left curve
          topRight: Radius.circular(30.0), // Adjust right curve
        ),
      ),
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
                30.0), // Match the same radius for the container
            topRight: Radius.circular(
                30.0), // Match the same radius for the container
          ),
          child: Container(
            height: 700, // Increased height
            color: Colors.white, // Background color of the bottom sheet
            child: Column(
              children: [
                // Show content based on listType
                Expanded(
                  child: listType == 'HomemateList'
                      ? HomemateList() // Show HomemateRoomScreen content
                      : RoomList(), // Show RoomListingPage content
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildServiceCard(
      String imagePath, double boxWidth, double imageHeight) {
    return Container(
      width: boxWidth, // Width of the box
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: imageHeight, // Height of the image, dynamic size
            fit: BoxFit.contain,
          ),
          // Optionally, you can add a title or other content here
        ],
      ),
    );
  }
}
