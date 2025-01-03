import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/controllers/homemates.controller.dart';
import 'package:flatemates_ui/controllers/room_controller.dart';
import 'package:flatemates_ui/controllers/tab.controller.dart';
import 'package:flatemates_ui/ui/screens/homemate_details_screen/homemate_details.dart';
import 'package:flatemates_ui/ui/screens/room_details_screen/room_details.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/savedItemScreen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../res/bottom/bottom_bar.dart';
import 'package:get/get.dart';
/*
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBarScreen()),

            );
          },
        ),
        title: const Text(
          "Homemates & Rooms",
          style: TextStyle(color: Color(0xFFB60F6E)),
        ),
        bottom: TabBar(
          controller: tabControllerState.tabController,
          // Assign TabController
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
          HomemateList(
            userId: '',
          ),
          RoomList(),
        ],
      ),
    );
  }
}*/

class HomemateList extends StatefulWidget {
  final String userId;

  HomemateList({Key? key, required this.userId,}) : super(key: key);

  @override
  State<HomemateList> createState() => _HomemateListState();
}

class _HomemateListState extends State<HomemateList> {
  final userId   = FirebaseAuth.instance.currentUser?.uid;

  void saveHomemateToFirestore(homemate) async {
    try {
      await FirebaseFirestore.instance
          .collection('savedHomemates')
          .doc(userId) // User ID as the parent document
          .collection('items') // Subcollection to store saved homemates
          .doc(homemate.userPhoneNumber) // Use userPhoneNumber as the document ID
          .set({
        'userName': homemate.userName,
        'age': homemate.age,
        'profession': homemate.profession,
        'userPhoneNumber': homemate.userPhoneNumber,
        'image': "assets/images/user.jpg",
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Homemate saved successfully');
    } catch (e) {
      print('Error saving homemate: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    print('HomemateList userId: $userId'); // Debug log to check userId

    final HomemateController homemateController = Get.put(HomemateController());

    return Scaffold(
        /*appBar: AppBar(
        title: const Text('Homemates'),
    actions: [
    IconButton(
    icon: const Icon(Icons.favorite), // A heart icon for saved homemates
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => SavedHomematesScreen(userId: userId!),
    ),
    );
    },
    ),
    ],
    ),*/
    body: Obx(() {
      // Watch for changes in the homemates list and loading state
      if (homemateController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (homemateController.isError.value) {
        return Center(child: Text(homemateController.errorMessage.value));
      }

      if (homemateController.homemates.isEmpty) {
        return const Center(child: Text('No homemates found.'));
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: homemateController.homemates.length,
        itemBuilder: (context, index) {
          final homemate = homemateController.homemates[index];

          return GestureDetector(
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeMateDetailsScreen(homemate: homemate),
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
                          child: Image.asset(
                          "assets/images/user.jpg",
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
                            saveHomemateToFirestore(homemate);

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
                        ElevatedButton.icon(
                          onPressed: () async {
                            final Uri _phoneUrl = Uri.parse('tel:${homemate.userPhoneNumber}');
                            try {
                              await launchUrl(_phoneUrl);  // Directly launch the dialer
                            } catch (e) {
                              print('Could not launch the dialer: $e');
                            }
                          },
                          icon: const Icon(Iconsax.call),
                          label: Text(
                            'Call ${homemate.userPhoneNumber}',
                            style: TextStyle(fontSize: 9),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                        )



                        // Call Button

                      ],
                    ),
                  ],
                ),
              ), // Light purple background
            ),
          );
        },
      );
    }),
    );
  }
}

class RoomList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RoomControllerFirebase roomController =
    Get.put(RoomControllerFirebase());

    return Scaffold(
      body: Obx(() {
        // Observe the isLoading state
        if (roomController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if rooms are available
        if (roomController.rooms.isEmpty) {
          return const Center(child: Text('No rooms available'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: roomController.rooms.length,
          itemBuilder: (context, index) {
            final room = roomController.rooms[index];
            return Card(
              color: Colors.purple,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
               /* title: Text(
                  'Room Type: ${room.roomType}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),*/
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                               "assets/images/house.png",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Room Type: ${room.roomType}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('Address: ${room.address}',
                                  style: const TextStyle(color: Colors.white)),
                              Text('Rent: ${room.roomRent}',
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                   /* Text(
                      'Address: ${room.address}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Rent: ${room.roomRent}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Home Type: ${room.homeType}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Move-in Date: ${room.moveInDate}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Occupancy: ${room.occupationPerRoom}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),*/
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Save Button
                        ElevatedButton.icon(
                          onPressed: () {
                            roomController.saveRoom(room);

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
                          onPressed: () async {
                            final Uri _phoneUrl = Uri.parse('tel:${room.mobileNumber}');
                            try {
                              if (await canLaunchUrl(_phoneUrl)) {
                                await launchUrl(_phoneUrl);
                              } else {
                                throw 'Could not launch the dialer';
                              }
                            } catch (e) {
                              print('Could not launch the dialer: $e');
                            }
                          },
                          icon: const Icon(Iconsax.call),
                          label: Text('Call: ${room.mobileNumber}'),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomDetailScreen(room: room),
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}

/*class RoomList extends StatelessWidget {
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
}*/
