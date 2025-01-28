import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/controllers/room_controller.dart';
import 'package:flatemates_ui/controllers/tab.controller.dart';
import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flatemates_ui/ui/screens/room_details_screen/room_details.dart';
import 'package:flutter/material.dart';

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
       /* leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFB60F6E)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBarScreen()),

            );
          },
        ),*/
        automaticallyImplyLeading: false,
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
          SavedRoomsScreen(currentUserId: userId,),
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
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation,
                          secondaryAnimation) =>
                          HomemateDetailsScreen(homemate: homemate),
                      transitionsBuilder: (context, animation,
                          secondaryAnimation, child) {
                        var tween = Tween(
                            begin: const Offset(0.0, 0.0),
                            end: Offset.zero)
                            .chain(
                            CurveTween(curve: Curves.ease));
                        var offsetAnimation =
                        animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
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
                                    'Name: ${homemate['userName']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text('Age: ${homemate['age']}',style:
                                  const TextStyle(color: Colors.white)),
                                  Text('Profession: ${homemate['profession']}',style:
                                  const TextStyle(color: Colors.white)),
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
                              icon: const Icon(Icons.call),
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
                            SizedBox(width: 30,),
                            ElevatedButton.icon(
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
                                    final homemateId = snapshot.data!.docs[index].id; // Get document ID
                                    print("Attempting to delete homemate with ID: $homemateId");
                                    if (homemateId == null) {
                                      print("Error: homemate['userId'] is null or undefined");
                                      return;
                                    }
                                    // Delete the homemate from Firebase
                                    await FirebaseFirestore.instance
                                        .collection('savedHomemates')
                                        .doc(userId)
                                        .collection('items')
                                        .doc(homemateId) // assuming userId is used for the document ID
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
                              icon: const Icon(Icons.delete),
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
                            ),

                          ],
                        ),
                      ],
                    ),
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
        iconTheme: IconThemeData(
            color: Color(0xFFB60F6E)
        ),
        backgroundColor: Color(0xfff8e6f1),
        elevation: 0,
        title: Text(homemate['userName'],style: TextStyle(color:  Color(0xFFB60F6E)),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFB60F6E)),
          onPressed: () {
          Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 16),
            _buildProfileSection(),
            _buildDetailRow( 'Age','${homemate['age']}',),
            _buildDetailRow( 'Profession','${homemate['profession']}',),
            _buildDetailRow('Gender', homemate['gender'] ?? 'N/A'),
            const SizedBox(height: 20),
            Text(
              'Preferences',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            homemate['preferences'] != null && homemate['preferences'].isNotEmpty
                ? _buildPreferenceRow(homemate['preferences'])
                : const Text(
              'No preferences available',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
//hello
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final Uri _phoneUrl = Uri.parse('tel:${homemate['userPhoneNumber']}');
                  try {
                    await launchUrl(_phoneUrl);
                  } catch (e) {
                    print('Could not launch the dialer: $e');
                  }
                },
                icon: const Icon(Icons.call,color: Colors.white,),
                label: const Text('Call', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB60F6E),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceRow(List<dynamic> preferences) {
    final predefinedPreferences = {
      'Pet Lover': 'assets/icons/pet.png',
      'Gym Person': 'assets/icons/gym.png',
      'Travel Person': 'assets/icons/travel.png',
      'Party Person': 'assets/icons/party.png',
      'Music Person': 'assets/icons/music.png',
      'Vegan Person': 'assets/icons/vegan.png',
      'Sports Person': 'assets/icons/sport.png',
      'Yoga Person': 'assets/icons/yoga.png',
      'Non-Alcoholic': 'assets/icons/alcoholic.png',
      'Shopping Person': 'assets/icons/shopping.png',
      'Friendly Person': 'assets/icons/friends.png',
      'Studious': 'assets/icons/studious.png',
      'Growth': 'assets/icons/growth.png',
      'Non-Smoker': 'assets/icons/non_smoker.png',
    };

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: preferences.map((preference) {
        final iconPath = predefinedPreferences[preference] ?? 'assets/icons/default_icon.png';
        return Column(
          children: [
            Image.asset(iconPath, height: 60, width: 60),
            const SizedBox(height: 4),
            Text(
              preference,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.purple, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${homemate['userName']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'tel:${homemate['userPhoneNumber']}',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    );
  }
}


///

class SavedRoomsScreen extends StatefulWidget {
  final String currentUserId;
  SavedRoomsScreen({required this.currentUserId});

  @override
  State<SavedRoomsScreen> createState() => _SavedRoomsScreenState();
}

class _SavedRoomsScreenState extends State<SavedRoomsScreen> {
  @override
  List<Room> savedRooms = []; // Define savedRooms as a list of Room objects

  Widget build(BuildContext context) {
    // Put the RoomControllerFirebase instance here
    final RoomControllerFirebase roomController = Get.put(RoomControllerFirebase());

    // Fetch saved rooms when the screen is loaded
    roomController.fetchSavedRooms(widget.currentUserId);

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
                          icon: const Icon(Icons.call),
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
                        ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

                              // Delete the room from Firebase using mobileNumber as the unique ID
                              await FirebaseFirestore.instance
                                  .collection('savedRooms')
                                  .doc(userId) // Use the logged-in user's ID
                                  .collection('items')
                                  .doc(room.mobileNumber) // Use mobileNumber as the document ID
                                  .delete();

                              // Remove the deleted room from the local list
                              savedRooms.removeWhere((savedRoom) => savedRoom.mobileNumber == room.mobileNumber);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Room deleted successfully.')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Failed to delete room.')),
                              );
                            }
                          },
                          icon: const Icon(Icons.delete),
                          label: Text('Delete'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                        )

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


