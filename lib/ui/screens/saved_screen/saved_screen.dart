import 'package:flatemates_ui/controllers/homemates.controller.dart';
import 'package:flatemates_ui/controllers/tab.controller.dart';
import 'package:flatemates_ui/ui/screens/homemate_details_screen/homemate_details.dart';
import 'package:flatemates_ui/ui/screens/room_details_screen/room_details.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../res/bottom/bottom_bar.dart';

import 'package:get/get.dart';

class HomemateRoomScreen extends StatelessWidget {
  final TabControllerState tabControllerState = Get.put(TabControllerState());
  @override
  Widget build(BuildContext context) {
    // Initialize the GetX TabController

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff8e6f1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFB60F6E)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          "Homemates & Rooms",
          style: TextStyle(color: Color(0xFFB60F6E)),
        ),
        bottom: TabBar(
          controller: tabControllerState.tabController, // Assign TabController
          indicatorColor: Colors.purple,
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          tabs: [
            const Tab(text: 'Homemate'),
            const Tab(text: 'Room'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabControllerState.tabController, // Assign TabController
        children: [
          HomemateList(),
          RoomList(),
        ],
      ),
    );
  }
}

class HomemateList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomemateController homemateController = Get.put(HomemateController());

    return Obx(() {
      // Watch for changes in the homemates list and loading state
      if (homemateController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: homemateController.homemates.length,
        itemBuilder: (context, index) {
          final homemate = homemateController.homemates[index];

          return GestureDetector(
            onTap: () {
              // Navigate to HomeMateDetailsScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeMateDetailsScreen(),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: Colors.purple,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${homemate.userName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('Age: ${homemate.age}',
                                  style: const TextStyle(color: Colors.white)),
                              Text('Profession: ${homemate.profession}',
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Save and Call Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Save Button
                        ElevatedButton.icon(
                          onPressed: () {
                            // Implement save action
                          },
                          icon: const Icon(Iconsax.save_2),
                          label: const Text('Save'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.green.shade100, // Save button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                        ),
                        // Call Button
                        ElevatedButton.icon(
                          onPressed: () {
                            // Implement call action
                          },
                          icon: const Icon(Iconsax.call),
                          label: const Text('Call'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blue.shade100, // Call button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ), // Light purple background
            ),
          );
        },
      );
    });
  }
}

class RoomList extends StatelessWidget {
  final List<Map<String, String>> rooms = [
    {
      'rent': '2600/-',
      'furnished': 'Fully',
      'location': 'Gachibowli, Hyderabad',
      'roomPic': 'assets/images/bad1.png',
    },
    {
      'rent': '2600/-',
      'furnished': 'Fully',
      'location': 'Gachibowli, Hyderabad',
      'roomPic': 'assets/images/bad2.png',
    },
    {
      'rent': '2600/-',
      'furnished': 'Fully',
      'location': 'Gachibowli, Hyderabad',
      'roomPic': 'assets/images/bad3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoomDetailScreen(),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          rooms[index]['roomPic']!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rent: ${rooms[index]['rent']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text('Furnished: ${rooms[index]['furnished']}',
                                style: const TextStyle(color: Colors.white)),
                            Text('Location: ${rooms[index]['location']}',
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      // const Icon(Icons.bookmark_border, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Save and Call Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Save Button
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement save action
                        },
                        icon: const Icon(Iconsax.save_2),
                        label: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green.shade100, // Save button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                      ),
                      // Call Button
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement call action
                        },
                        icon: const Icon(Iconsax.call),
                        label: const Text('Call'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.blue.shade100, // Call button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            color: Colors.purple,
          ),
        );
      },
    );
  }
}
