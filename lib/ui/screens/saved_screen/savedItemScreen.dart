import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flatemates_ui/controllers/room_controller.dart';
import 'package:flatemates_ui/controllers/tab.controller.dart';
import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flatemates_ui/ui/screens/room_details_screen/room_details.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../homemate_details_screen/homemate_details.dart';

class SavedTabBarScreen extends StatelessWidget {
  final TabControllerState tabControllerState = Get.put(TabControllerState());

  @override
  Widget build(BuildContext context) {

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

          SavedHomematesScreen(userId: userId,),
          SavedRoomsScreen(),
        ],
      ),
    );
  }
}

///

class SavedHomematesScreen extends StatelessWidget {
  final String userId;

  const SavedHomematesScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

 /*     appBar: AppBar(
        title: const Text('Saved Homemates'),
      ),*/
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('savedHomemates')
            .doc(userId)
            .collection('items')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No saved homemates.'));
          }

          final savedHomemates = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: savedHomemates.length,
            itemBuilder: (context, index) {
              final homemate = savedHomemates[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                           HomemateDetailsScreen(homemate: homemate),

                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Name: ${homemate['userName']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                Text('Age: ${homemate['age']}'),
                                Text('Profession: ${homemate['profession']}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              final Uri _phoneUrl =
                              Uri.parse('tel:${homemate['userPhoneNumber']}');
                              try {
                                await launchUrl(_phoneUrl); // Directly launch the dialer
                              } catch (e) {
                                print('Could not launch the dialer: $e');
                              }
                            },
                            icon: const Icon(Iconsax.call),
                            label: Text(
                           //   'Call ${homemate['userPhoneNumber']}',
                              'Call',
                              style: const TextStyle(fontSize: 9),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                          ),
                      /*    ElevatedButton.icon(

                            onPressed: () async {

                              // Confirm before unsaving

                              final bool? confirm = await showDialog(

                                context: context,

                                builder: (context) => AlertDialog(

                                  title: const Text('Remove Homemate'),

                                  content: const Text('Are you sure you want to unsave this homemate?'),

                                  actions: [

                                    TextButton(

                                      onPressed: () => Navigator.pop(context, false),

                                      child: const Text('Cancel'),

                                    ),

                                    TextButton(

                                      onPressed: () => Navigator.pop(context, true),

                                      child: const Text('Remove'),

                                    ),

                                  ],

                                ),

                              );



                              if (confirm == true) {

                                try {

                                  await FirebaseFirestore.instance

                                      .collection('savedHomemates')

                                      .doc(userId)

                                      .collection('items')

                                      .doc(homemate["userId"])

                                      .delete();

                                  ScaffoldMessenger.of(context).showSnackBar(

                                    const SnackBar(content: Text('Homemate removed successfully.')),

                                  );

                                } catch (e) {

                                  print('Error removing homemate: $e');

                                  ScaffoldMessenger.of(context).showSnackBar(

                                    const SnackBar(content: Text('Failed to remove homemate.')),

                                  );

                                }

                              }

                            },

                            icon: const Icon(Iconsax.trash),

                            label: const Text(

                              'Unsave',

                              style: TextStyle(fontSize: 9),

                            ),

                            style: ElevatedButton.styleFrom(

                              backgroundColor: Colors.red.shade100,

                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(8),

                              ),

                              padding: const EdgeInsets.symmetric(

                                horizontal: 20,

                                vertical: 10,

                              ),

                            ),

                          ),*/
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class HomemateDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> homemate;

  const HomemateDetailsScreen({Key? key, required this.homemate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homemate['userName']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/user.jpg",
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Name: ${homemate['userName']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Age: ${homemate['age']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Profession: ${homemate['profession']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                final Uri _phoneUrl = Uri.parse('tel:${homemate['userPhoneNumber']}');
                try {
                  await launchUrl(_phoneUrl); // Directly launch the dialer
                } catch (e) {
                  print('Could not launch the dialer: $e');
                }
              },
              icon: const Icon(Iconsax.call),
              label: const Text('Call Homemate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


///

class SavedRoomsScreen extends StatefulWidget {
  @override
  State<SavedRoomsScreen> createState() => _SavedRoomsScreenState();
}

class _SavedRoomsScreenState extends State<SavedRoomsScreen> {
  @override
  Widget build(BuildContext context) {
    // Put the RoomControllerFirebase instance here
    final RoomControllerFirebase roomController = Get.put(RoomControllerFirebase());

    // Fetch saved rooms when the screen is loaded
    roomController.fetchSavedRooms();

    return Scaffold(
   /*   appBar: AppBar(
        title: const Text("Saved Rooms"),
      ),*/
      body: Obx(() {
        if (roomController.savedRooms.isEmpty) {
          return const Center(child: Text("No rooms saved yet."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: roomController.savedRooms.length,
          itemBuilder: (context, index) {
            final room = roomController.savedRooms[index];
            return Card(
              color: Colors.purple,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child:  ListTile(
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
                         // label: Text('Call: ${room.mobileNumber}'),
                          label: Text('Call'),
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
                      builder: (context) => RoomDetailScreen(room: room, ),
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


