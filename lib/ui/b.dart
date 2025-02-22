/// savedItemScreen
/*import 'package:cloud_firestore/cloud_firestore.dart';
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

*/

/// SavedScreen
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/controllers/homemates.controller.dart';
import 'package:flatemates_ui/controllers/room_controller.dart';
import 'package:flatemates_ui/ui/screens/homemate_details_screen/homemate_details.dart';
import 'package:flatemates_ui/ui/screens/room_details_screen/room_details.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../../res/bottom/bottom_bar.dart';
import 'package:get/get.dart';

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
        'gender': homemate.gender, // Add gender
        'preferences': homemate.preferences, // Add preferences
        'image': "assets/images/user.jpg",
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Homemate saved successfully');
    } catch (e) {
      print('Error saving homemate: $e');
    }
  }

  void shareHomemateDetails(homemate) {
    // Construct the unique URL for the room
    final String roomUrl = 'https://homemates-app.web.app/room/${userId}';

    // Create the shareable content
    final String shareText = '''
Check out this homemate:
Name: ${homemate.userName}
Age: ${homemate.age}
Profession: ${homemate.profession}

Explore more details here: $roomUrl
''';


    Share.share(shareText);
  }
  @override
  Widget build(BuildContext context) {
    final HomemateController homemateController = Get.put(HomemateController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff8e6f1),
        iconTheme: IconThemeData(
            color: Color(0xFFB60F6E)
        ),
        title: const Text(
            "Homemates for you",style: TextStyle(color: Color(0xFFB60F6E))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation,
                    secondaryAnimation) =>
                    BottomNavBarScreen(),
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
        ),
        // title: const Text('Homemates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
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
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFB60F6E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Apply Filter',style: TextStyle(color: Colors.white),),
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
                  PageRouteBuilder(
                    pageBuilder: (context, animation,
                        secondaryAnimation) =>
                        HomeMateDetailsScreen(homemate: homemate),
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
                              homemate.gender.toLowerCase() == 'male'
                                  ? "assets/images/user.jpg"
                                  : "assets/icons/female.png",
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
                            label: const Text('Save',),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffACE7E6),
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
                              backgroundColor: Color(0xffFFF5BA),
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
                              backgroundColor: Color(0xffFAD4E4),
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
        backgroundColor: Color(0xfff8e6f1),
        title:
        const Text("Rooms for you",style: TextStyle(color: Color(0xFFB60F6E))),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Color(0xFFB60F6E)),
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                pageBuilder: (context, animation,
                secondaryAnimation) =>
                BottomNavBarScreen(),
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
            },),);          },
        ),
        // title: const Text('Room List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list,color: Color(0xFFB60F6E)),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                isScrollControlled: true,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          value: selectedRoomType,
                          hint: const Text('Select Room Type'),
                          isExpanded: true,
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
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB60F6E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Apply Filter',
                            style: TextStyle(color: Colors.white),
                          ),
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
                          icon: const Icon(Icons.save),
                          label: const Text('Save'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:Color(0xffACE7E6),
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
                          icon: const Icon(Icons.call),
                          label: const Text('Call'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:Color(0xffFFF5BA),
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
                            backgroundColor: Color(0xffFAD4E4), // Share button color
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
                    PageRouteBuilder(
                      pageBuilder: (context, animation,
                          secondaryAnimation) =>
                          RoomDetailScreen(room: room,),
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
                      },),);
                },
              ),
            );
          },
        );
      }),
    );
  }

}



*/

/// room_controller
/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RoomControllerFirebase extends GetxController {
  var rooms = <Room>[].obs; // Observable for room list
  var isLoading = true.obs; // Observable for loading state
  var savedRooms = <Room>[].obs; // List of saved rooms

  @override
  void onInit() {
    super.onInit();
    fetchRooms(); // Fetch room data when the controller is initialized
  }

  Future<void> fetchRooms() async {
    try {
      isLoading.value = true; // Start loading
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch data from Firestore
      QuerySnapshot snapshot = await firestore.collection('rooms').get();
      rooms.value = snapshot.docs.map((doc) {
        return Room.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching rooms: $e');
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Fetch saved rooms from Firestore
  Future<void> fetchSavedRooms() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await firestore.collection('saved_rooms').get();
      savedRooms.value = snapshot.docs.map((doc) {
        return Room.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching saved rooms: $e');
    }
  }

  // Save a room to Firestore
  Future<void> saveRoom(Room room) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Check if room is already saved in Firestore
      final snapshot = await firestore
          .collection('saved_rooms')
          .where('userId', isEqualTo: room.userId) // Assuming userId is unique for each room
          .get();

      if (snapshot.docs.isEmpty) {
        // Save the room in Firestore
        await firestore.collection('saved_rooms').add(room.toMap());

        // Add to local list
        savedRooms.add(room);

        Get.snackbar('Success', 'Room saved successfully!');
      } else {
        Get.snackbar('Info', 'Room is already saved.');
      }
    } catch (e) {
      print('Error saving room: $e');
      Get.snackbar('Error', 'Failed to save the room.');
    }
  }
}

class Room {

  final String address;
  final String homeType;
  final String moveInDate;
  final String occupationPerRoom;
  final String roomRent;
  final String roomType;
  final String userId;
  final String mobileNumber;
  final List<String> selectedValues;
  List<String> profileImages;



  Room({
    required this.address,
    required this.homeType,
    required this.moveInDate,
    required this.occupationPerRoom,
    required this.roomRent,
    required this.roomType,
    required this.userId,
    required this.mobileNumber,
    required this.selectedValues,
    required this.profileImages,


  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'homeType': homeType,
      'moveInDate': moveInDate,
      'occupationPerRoom': occupationPerRoom,
      'roomRent': roomRent,
      'roomType': roomType,
      'userId': userId,
      'mobileNumber': mobileNumber,
      'selectedValues': selectedValues,
      'profileImages': profileImages,

    };
  }
  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      address: map['address'] ?? '',
      homeType: map['homeType'] ?? '',
      moveInDate: map['moveInDate'] ?? '',
      occupationPerRoom: map['occupationPerRoom'] ?? '',
      roomRent: map['roomRent'] ?? '',
      roomType: map['roomType'] ?? '',
      userId: map['userId'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      selectedValues: List<String>.from(map['selectedValues'] ?? []),
      profileImages: List<String>.from(map['profileImages'] ?? []),


    );
  }
}

*/

/// catch file remove
/*import 'package:flutter/material.dart';
import 'dart:html' as html; // Needed for browser operations
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _clearCacheAndRefresh() async {
    // 1. Sign out Firebase user (optional)
    await FirebaseAuth.instance.signOut();

    // 2. Clear Service Worker & Cache Storage (for Flutter Web)
    html.window.location.reload(); // Reloads the page with fresh cache
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _clearCacheAndRefresh, // Called on pull-to-refresh
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(), // Enables pull-down even if not scrollable
          children: [
            SizedBox(height: 100), // Just for spacing
            Center(child: Text("Login Screen", style: TextStyle(fontSize: 24))),
            // Add your login form here
          ],
        ),
      ),
    );
  }
}
*/


/// catch file remove
/*Future<void> _clearCacheAndRefresh() async {
  await FirebaseAuth.instance.signOut(); // Optional logout

  // Clear Service Worker cache
  html.window.navigator.serviceWorker?.getRegistrations().then((registrations) {
    for (var registration in registrations) {
      registration.unregister(); // Unregister all service workers
    }
  });

  // Reload the page
  html.window.location.reload();
}
*/

/// Phone number
/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberField extends StatefulWidget {
  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final TextEditingController phoneController = TextEditingController();
  String? phoneError;

  void _validatePhoneNumber(String value) {
    // Only allow numbers starting with 9, 8, 7, or 6
    if (value.isNotEmpty && !RegExp(r'^[9876]').hasMatch(value)) {
      setState(() {
        phoneError = "Phone number must start with 9, 8, 7, or 6";
      });
    } else if (value.length > 10) {
      // Enforce max 10 digits
      phoneController.text = value.substring(0, 10);
      phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length));
    } else {
      setState(() {
        phoneError = null; // No error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Only allow digits
            LengthLimitingTextInputFormatter(10), // Limit to 10 digits
          ],
          decoration: InputDecoration(
            labelText: 'Phone number*',
            errorText: phoneError, // Show error if invalid
          ),
          onChanged: _validatePhoneNumber, // Validate on change
        ),
      ],
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AddressMapWeb extends StatefulWidget {
  final String address;

  const AddressMapWeb({Key? key, required this.address}) : super(key: key);

  @override
  _AddressMapWebState createState() => _AddressMapWebState();
}

class _AddressMapWebState extends State<AddressMapWeb> {
  late InAppWebViewController _webViewController;
  String googleMapsApiKey = "YOUR_GOOGLE_MAPS_API_KEY";

  @override
  Widget build(BuildContext context) {
    String mapHtml = """
    <!DOCTYPE html>
    <html>
    <head>
      <script src="https://maps.googleapis.com/maps/api/js?key=$googleMapsApiKey"></script>
      <script>
        function initMap() {
          var geocoder = new google.maps.Geocoder();
          var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 14,
            center: { lat: 0, lng: 0 }
          });

          geocoder.geocode({ 'address': '${widget.address}' }, function(results, status) {
            if (status === 'OK') {
              map.setCenter(results[0].geometry.location);
              new google.maps.Marker({
                map: map,
                position: results[0].geometry.location
              });
            } else {
              alert('Geocode was not successful: ' + status);
            }
          });
        }
      </script>
    </head>
    <body onload="initMap()">
      <div id="map" style="width:100%; height:100vh;"></div>
    </body>
    </html>
    """;

    return Scaffold(
      appBar: AppBar(title: Text("Map View")),
      body: InAppWebView(
        initialData: InAppWebViewInitialData(data: mapHtml),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
      ),
    );
  }
}
