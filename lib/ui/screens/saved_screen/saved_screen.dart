import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/controllers/homemates.controller.dart';
import 'package:flatemates_ui/controllers/room_controller.dart';
import 'package:flatemates_ui/controllers/tab.controller.dart';
import 'package:flatemates_ui/ui/screens/homemate_details_screen/homemate_details.dart';
import 'package:flatemates_ui/ui/screens/room_details_screen/room_details.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/savedItemScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
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

/*class HomemateList extends StatefulWidget {
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
        *//*appBar: AppBar(
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
    ),*//*
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
                         //   'Call ${homemate.userPhoneNumber}',
                            'Call',
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
}*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class HomemateList extends StatefulWidget {
  final String userId;

  HomemateList({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomemateList> createState() => _HomemateListState();
}

class _HomemateListState extends State<HomemateList> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final RxString selectedGender = ''.obs;
  final RxInt selectedAge = 0.obs;

  void saveHomemateToFirestore(homemate) async {
    try {
      await FirebaseFirestore.instance
          .collection('savedHomemates')
          .doc(userId)
          .collection('items')
          .doc(homemate.userPhoneNumber)
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

  void shareHomemateDetails(homemate) {
    final String shareText =
        'Check out this homemate:\n\nName: ${homemate.userName}\nAge: ${homemate.age}\nProfession: ${homemate.profession}\nPhone: ${homemate.userPhoneNumber}';
    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    final HomemateController homemateController = Get.put(HomemateController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homemates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                          ),
                          items: ['Male', 'Female', 'Other']
                              .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                              .toList(),
                          onChanged: (value) {
                            selectedGender.value = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Age',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            selectedAge.value = int.tryParse(value) ?? 0;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Apply Filter'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (homemateController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (homemateController.isError.value) {
          return Center(child: Text(homemateController.errorMessage.value));
        }

        final filteredHomemates = homemateController.homemates.where((homemate) {
          final matchesGender = selectedGender.value.isEmpty ||
              homemate.gender == selectedGender.value;
          final matchesAge = selectedAge.value == 0 ||
              homemate.age == selectedAge.value;
          return matchesGender && matchesAge;
        }).toList();

        if (filteredHomemates.isEmpty) {
          return const Center(child: Text('No homemates found.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredHomemates.length,
          itemBuilder: (context, index) {
            final homemate = filteredHomemates[index];

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
                                    style:
                                    const TextStyle(color: Colors.white)),
                                Text('Profession: ${homemate.profession}',
                                    style:
                                    const TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              saveHomemateToFirestore(homemate);
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Save'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final Uri _phoneUrl =
                              Uri.parse('tel:${homemate.userPhoneNumber}');
                              try {
                                await launchUrl(_phoneUrl);
                              } catch (e) {
                                print('Could not launch the dialer: $e');
                              }
                            },
                            icon: const Icon(Icons.call),
                            label: const Text('Call'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              shareHomemateDetails(homemate);
                            },
                            icon: const Icon(Icons.share),
                            label: const Text('Share'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade100,
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
              ),
            );
          },
        );
      }),
    );
  }
}



class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  final RoomControllerFirebase roomController = Get.put(RoomControllerFirebase());

  String? selectedRoomType;
  double? selectedRent;
  List<String> roomTypes = ["1BHK", "2BHK", "3BHK"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Filter Rooms'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Room Type Filter
                        DropdownButton<String>(
                          value: selectedRoomType,
                          hint: const Text('Select Room Type'),
                          onChanged: (newValue) {
                            setState(() {
                              selectedRoomType = newValue;
                            });
                          },
                          items: roomTypes
                              .map<DropdownMenuItem<String>>(
                                  (type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              ))
                              .toList(),
                        ),
                        // Rent Filter
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Apply'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),

      body: Obx(() {
        if (roomController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Filter the rooms based on the selected filters
        List<Room> filteredRooms = roomController.rooms;
        if (selectedRoomType != null) {
          filteredRooms = filteredRooms
              .where((room) => room.roomType == selectedRoomType)
              .toList();
        }


        if (filteredRooms.isEmpty) {
          return const Center(child: Text('No rooms available'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredRooms.length,
          itemBuilder: (context, index) {
            final room = filteredRooms[index];
            return Card(
              color: Colors.purple,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
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
                          label: const Text('Call'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade100, // Call button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                        ),
                        // Share Button
                        ElevatedButton.icon(
                          onPressed: () async {
                            final String shareContent =
                                'Check out this room:\nRoom Type: ${room.roomType}\nAddress: ${room.address}\nRent: ${room.roomRent}\nContact: ${room.mobileNumber}';
                            Share.share(shareContent);
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade100, // Share button color
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
                      builder: (context) => RoomDetailScreen(room: room,),
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
}*/