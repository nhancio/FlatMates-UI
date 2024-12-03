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
        backgroundColor: Color(0xfff8e6f1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFB60F6E)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
              (route) => false,
            );
          },
        ),
        title: Text(
          "Homemates & Rooms",
          style: TextStyle(color: Color(0xFFB60F6E)),
        ),
        bottom: TabBar(
          controller: tabControllerState.tabController, // Assign TabController
          indicatorColor: Colors.purple,
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Homemate'),
            Tab(text: 'Room'),
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
  final List<Map<String, String>> homemates = [
    {
      'name': 'Daniel',
      'age': '26',
      'profession': 'Artist',
      'location': 'Gachibowli, Hyderabad',
      'profilePic': 'assets/images/john.png',
    },
    {
      'name': 'Sara',
      'age': '24',
      'profession': 'Athlete',
      'location': 'Madhapur, Hyderabad',
      'profilePic': 'assets/images/sara.png',
    },
    {
      'name': 'Mike',
      'age': '27',
      'profession': 'Traveler',
      'location': 'Jubilee Hills, Hyderabad',
      'profilePic': 'assets/images/sohan.png',
    },
    {
      'name': 'Andera',
      'age': '26',
      'profession': 'Dancer',
      'location': 'Gachibowli, Hyderabad',
      'profilePic': 'assets/images/andera.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: homemates.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeMateDetailsScreen(),
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
                          homemates[index]['profilePic']!,
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
                              'Name: ${homemates[index]['name']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text('Age: ${homemates[index]['age']}',
                                style: const TextStyle(color: Colors.white)),
                            Text('Profession: ${homemates[index]['profession']}',
                                style: const TextStyle(color: Colors.white)),
                            Text('Location: ${homemates[index]['location']}',
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
                        icon:  Icon(Iconsax.save_2),
                        label: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade100, // Save button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          backgroundColor: Colors.blue.shade100, // Call button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            color: Colors.purple, // Light purple background
          ),
        );
      },
    );
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
                                  fontWeight: FontWeight.bold, color: Colors.white),
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
                        icon:  Icon(Iconsax.save_2),
                        label: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade100, // Save button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          backgroundColor: Colors.blue.shade100, // Call button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
