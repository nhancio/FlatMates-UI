import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/controllers/bottomnav.controller.dart';
import 'package:flatemates_ui/controllers/tab.controller.dart';
import 'package:flatemates_ui/ui/screens/list_my_room_screen/list_my_room.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  final String userId;

  HomePage({required this.userId});


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomNavController bottomNavController = Get.put(BottomNavController());
  TabControllerState tabCtrl = Get.put(TabControllerState());
  final userId = FirebaseAuth.instance.currentUser?.uid;

  String? selectedCity;
  final List<String> cities = [
    'Hitech City, Hyderabad',
    'Kondapur, Hyderabad',
    'Marathahalli, Bangalore',
  ];
  List<String> filteredCities = [];
  bool showDropdown = false; // Controls visibility of dropdown list
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCities = cities; // Initialize filtered list with all cities
  }

  void filterCities(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCities = cities;
      } else {
        filteredCities = cities
            .where((city) => city.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<Map<String, String>> fetchUserDetails(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        String userName = userDoc['userName'] ?? 'N/A';

        return {
          'userName': userName,
        };
      } else {
        return {
          'userName': 'User not found',
        };
      }
    } catch (e) {
      return {
        'userName': 'Error',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'User not logged in. Please log in first.',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;
          return Stack(
            children: [
              // Background Image
              /*  Positioned(
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
              ),*/
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
                      FutureBuilder<Map<String, String>>(
                        future: fetchUserDetails(userId!), // Pass userId here
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Row(
                              children: const [
                                // CircularProgressIndicator(),
                                SizedBox(width: 10),
                                Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return const Text(
                              'Error fetching data!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            );
                          } else if (snapshot.hasData) {
                            final userDetails = snapshot.data!;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hi ${userDetails['userName']}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFB60F6E),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const Text(
                              'User not found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            );
                          }
                        },
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

                          border: Border.all(
                              color: Colors.grey
                                  .withOpacity(0.5)), // Adding border
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Search Bar
                              TextFormField(
                                controller: searchController,
                                readOnly: true, // Prevent manual typing
                                onTap: () {
                                  setState(() {
                                    showDropdown =
                                        !showDropdown; // Toggle dropdown visibility
                                    if (!showDropdown) {
                                      filteredCities =
                                          cities; // Reset list when closing dropdown
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search,
                                      color: Colors.grey[600]),
                                  hintText: selectedCity ??
                                      'Search or select locality',
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Dropdown Items
                              if (showDropdown)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Colors.grey[300]!),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    // Ensures dropdown doesn't overflow
                                    itemCount: filteredCities.length,
                                    itemBuilder: (context, index) {
                                      final city = filteredCities[index];
                                      return ListTile(
                                        title: Text(city),
                                        onTap: () {
                                          setState(() {
                                            selectedCity =
                                                city; // Update selected city
                                            searchController.text =
                                                city; // Show in search bar
                                            showDropdown =
                                                false; // Hide dropdown
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
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
                                          body: HomemateList(userId: '',),
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
      isScrollControlled: true,
      // Allows flexible height
      backgroundColor: Colors.transparent,
      // To make the background transparent
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
                      ? HomemateList(
                          userId: '',
                        ) // Show HomemateRoomScreen content
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

