import 'package:cloud_firestore/cloud_firestore.dart';
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




