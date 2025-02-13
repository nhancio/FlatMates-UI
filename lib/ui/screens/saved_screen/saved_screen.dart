import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/controllers/homemates.controller.dart';
import 'package:flatemates_ui/controllers/room_controller.dart';
import 'package:flatemates_ui/models/userprofile.model.dart';
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
  final RxString selectedProfession = ''.obs;
  String userGender = 'Loading...';
  UserProfile? loggedInUser;


  @override
  void initState() {
    super.initState();
    fetchUserGender(userId!);
    getLoggedInUserProfile(FirebaseAuth.instance.currentUser?.uid ?? "").then((userData) {

      setState(() {
        loggedInUser = userData;
      });
    });
  }


  void saveHomemateToFirestore(homemate) async {
    try {
      if (homemate.userPhoneNumber == null || homemate.userPhoneNumber.isEmpty) {
        throw Exception("Invalid phone number. Cannot save homemate.");
      }

      if (userId == null || userId!.isEmpty) {
        throw Exception("User ID is missing. Please log in again.");
      }

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
      Get.snackbar(
        'Success',
        'Homemate saved successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey.shade100,
        colorText: Colors.black,
        duration: Duration(seconds: 2),
      );

      print('Homemate saved successfully');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save homemate',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
        duration: Duration(seconds: 3),
      );
    }
  }

  Future<String> fetchUserGender(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        String gender = userDoc['gender'] ?? 'N/A';
        print("Fetched Gender: $gender");  // Print the fetched gender
        setState(() {
          selectedGender.value = gender;  // Update selectedGender
        });
        return gender;
      } else {
        print("No user found with this ID.");
        selectedGender.value = 'N/A';
        return 'N/A';  // Return a default value if the document does not exist
      }
    } catch (e) {
      print("Error fetching user gender: $e");  // Print any errors that occur
      selectedGender.value = 'Error';
      return 'Error';  // Return 'Error' if an exception occurs
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
  Future<void> _refresh() async {
    setState(() {});
  }


  Future<UserProfile?> getLoggedInUserProfile(String uid) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      return UserProfile.fromMap(userDoc.data() as Map<String, dynamic>);
    }
    return null; // Return null if user does not exist
  }

  double calculateMatchPercentage(Map<String, dynamic> userProfile, Map<String, dynamic> homemateProfile) {
    double score = 0;
    double totalWeight = 10.0;


    if (userProfile['gender'] == homemateProfile['gender']) score += 2;


    if (userProfile['profession'] == homemateProfile['profession']) score += 3;


    int ageDiff = (userProfile['age'] - homemateProfile['age']).abs();
    if (ageDiff <= 2) {
      score += 2;
    } else if (ageDiff <= 5) {
      score += 1;
    }


    if (userProfile['preference'] == homemateProfile['preference']) score += 3;


    double randomFactor = (5 - (Random().nextInt(10))) / 100.0;


    double finalPercentage = ((score / totalWeight) * 100) * (1 + randomFactor);

    return finalPercentage.clamp(50.0, 98.0); // Ensures no match is too low or too high
  }

  @override
  Widget build(BuildContext context) {
    final HomemateController homemateController = Get.put(HomemateController());
    if (loggedInUser == null) {
      return const Center(child: Text(""));  // Show a loader until data loads
    }
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Go back to Home
        return false; // Prevent default back action (no dialog here)
      },
      child: Scaffold(
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
                       /*   DropdownButtonFormField<String>(
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
                          ),*/
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
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Select Profession',

                            ),
                            items: [
                              'IT',
                              'Medicine',
                              'Student',
                              'Seeking Job',
                              'Content Creator',
                              'Others',
                            ]
                                .map((profession) => DropdownMenuItem(
                              value: profession,
                              child: Text(profession),
                            ))
                                .toList(),
                            onChanged: (value) {
                              selectedProfession.value = value!; // Update the reactive variable
                            },
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
                          ),



                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  selectedAge.value = 0;
                                  selectedProfession.value = '';
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFB60F6E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Clear', style: TextStyle(color: Colors.white)),
                              ),

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
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Obx(() {
            if (homemateController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (homemateController.isError.value) {
              return Center(child: Text(homemateController.errorMessage.value));
            }
            String selectedGenderValue = selectedGender.value.isEmpty ? 'N/A' : selectedGender.value;
            final filteredHomemates = homemateController.homemates.where((homemate) {
              final matchesGender = selectedGender.value.isEmpty ||
                  homemate.gender == selectedGender.value;
              final matchesAge = selectedAge.value == 0 ||
                  homemate.age == selectedAge.value;
              final matchesProfession = selectedProfession.value.isEmpty || homemate.profession == selectedProfession.value;

              return matchesGender && matchesAge && matchesProfession;
            }).toList();

            if (filteredHomemates.isEmpty) {
              return const Center(child: Text('No homemates found.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredHomemates.length,
              itemBuilder: (context, index) {
                final homemate = filteredHomemates[index];
                final matchPercentage = calculateMatchPercentage(loggedInUser!.toMap(), homemate.toMap());



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
                                    Text('Match: ${matchPercentage.toStringAsFixed(1)}%',   style:
                                    const TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20),
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
                                SizedBox(width: 30),
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
                                SizedBox(width: 8),
                           /*     ElevatedButton.icon(
                                  onPressed: () async {
                                    final String shareContent =
                                        'Check out this room:\User name: ${homemate.userName}\nAge: ${homemate.age}\nRent: ${homemate.profession}\nContact: ${homemate.userPhoneNumber}';

                                    final String whatsappUrl = 'whatsapp://send?text=$shareContent';

                                    // Check if WhatsApp is installed
                                    if (await canLaunch(whatsappUrl)) {
                                      await launch(whatsappUrl);
                                    } else {
                                      // If WhatsApp is not installed, you can show an error or fallback
                                      Get.snackbar(
                                        'Error',
                                        'WhatsApp is not installed',
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.red.shade100,
                                        colorText: Colors.black,
                                        duration: Duration(seconds: 2),
                                      );

                                    }
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
                                ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}



class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  final RoomControllerFirebase roomController = Get.put(RoomControllerFirebase());
  TextEditingController searchController = TextEditingController();

  String? selectedRoomType;
  String? selectedHomeType;
  String? selectedMoveDate;
  String? selectedOccupation;
  double? selectedRent;
  List<String> roomTypes = ["1BHK", "2BHK", "3BHK"];
  List<String> moveDate = ["Immediately", "1 Month", "3 Months"];
  List<String> occupation = ["1 Person", "2 Persons", "3 Persons"];
  List<String> homeTypes = [ "Apartment",
    "Individual House",
    "Gated Community Flat",
    "Villa"];
  @override
  void initState() {
    super.initState();
    final selectedCity = Get.arguments?['city'] ?? "";
    searchController.text = selectedCity;
  }

  /*void saveRoom(Room room) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var uuid = Uuid();

    String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      print("User not logged in.");
      return;
    }

    try {
      // Generate a unique ID for each room
      String roomId = uuid.v4();

      DocumentReference roomRef = _firestore
          .collection('saved_Rooms')
          .doc(userId)
          .collection('savedRooms')
          .doc(roomId); // Use unique ID

      await roomRef.set({
        'roomId': roomId, // Store room ID
        'roomType': room.roomType,
        'homeType': room.homeType,
        'address': room.address,
        'roomRent': room.roomRent,
        'roomMoveInDate': room.moveInDate,
        'roomOccupationPerRoom': room.occupationPerRoom,
        'roomMobileNumber': room.mobileNumber,
        'userId': userId,
        'roomSelectedValues': room.selectedValues,
        'roomProfileImages': room.profileImages,
      });
      Get.snackbar(
        'Success',
        'Room saved successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey.shade100,
        colorText: Colors.black,
        duration: Duration(seconds: 2),
      );

      print('Homemate saved successfully');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed  saving room',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
        duration: Duration(seconds: 3),
      );
    }
  }*/

  void saveRoom(Room room) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      print("User not logged in.");
      return;
    }

    try {
      CollectionReference savedRoomsRef = _firestore
          .collection('saved_Rooms')
          .doc(userId)
          .collection('savedRooms');

      // Use a unique identifier for the room (e.g., address + userId)
      String roomId = '${room.address}_${userId}'; // Unique key for each user-room pair

      DocumentReference roomRef = savedRoomsRef.doc(roomId);

      // Check if the room already exists
      DocumentSnapshot existingRoom = await roomRef.get();

      if (existingRoom.exists) {
        // Room is already saved, show a Snackbar
        Get.snackbar(
          'Info',
          'Room is already saved!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blue.shade100,
          colorText: Colors.black,
          duration: Duration(seconds: 2),
        );
        return;
      }

      // Save the room using a consistent roomId
      await roomRef.set({
        'roomId': roomId, // Now using a consistent identifier
        'roomType': room.roomType,
        'homeType': room.homeType,
        'address': room.address,
        'roomRent': room.roomRent,
        'roomMoveInDate': room.moveInDate,
        'roomOccupationPerRoom': room.occupationPerRoom,
        'roomMobileNumber': room.mobileNumber,
        'userId': userId,
        'roomSelectedValues': room.selectedValues,
        'roomProfileImages': room.profileImages,
        'brokerage': room.brokerage,
        'description': room.description,
        'securityDeposit': room.securityDeposit,
        'setupCost': room.setup,
      });

      Get.snackbar(
        'Success',
        'Room saved successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey.shade100,
        colorText: Colors.black,
        duration: Duration(seconds: 2),
      );

      print('Room saved successfully');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save room',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
        duration: Duration(seconds: 3),
      );
      print('Error saving room: $e');
    }
  }

  Future<void> _refresh() async {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Go back to Home
        return false; // Prevent default back action (no dialog here)
      },
      child: Scaffold(
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
                        DropdownButtonFormField<String>(
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
                          ),
                        )
                            .toList(),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
                      ),
                          DropdownButtonFormField<String>(
                            value: selectedHomeType,
                            hint: const Text('Home Type'),
                            isExpanded: true,
                            onChanged: (newValue) {
                              setState(() {
                                selectedHomeType = newValue;
                              });
                            },
                            items: homeTypes
                                .map<DropdownMenuItem<String>>(
                                  (type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              ),
                            )
                                .toList(),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
                          ),

                          DropdownButtonFormField<String>(
                            value: selectedMoveDate,
                            hint: const Text('Move Date'),
                            isExpanded: true,
                            onChanged: (newValue) {
                              setState(() {
                                selectedMoveDate = newValue;
                              });
                            },
                            items: moveDate
                                .map<DropdownMenuItem<String>>(
                                  (type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              ),
                            )
                                .toList(),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
                          ),

                          DropdownButtonFormField<String>(
                            value: selectedOccupation,
                            hint: const Text('Select Occupation'),
                            isExpanded: true,
                            onChanged: (newValue) {
                              setState(() {
                                selectedOccupation = newValue;
                              });
                            },
                            items: occupation
                                .map<DropdownMenuItem<String>>(
                                  (type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              ),
                            )
                                .toList(),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
                          ),



                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedRoomType = null;
                                    selectedHomeType = null;
                                    selectedMoveDate = null;
                                    selectedOccupation = null;
                                    Get.back();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB60F6E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Clear',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),

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
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],

        ),

        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search by only address",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (query) {
                    setState(() {}); // Update UI when search input changes
                  },
                ),
              ),
              Expanded(
                child: Obx(() {
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
                  if (selectedHomeType != null) {
                    filteredRooms = filteredRooms
                        .where((room) => room.homeType == selectedHomeType)
                        .toList();
                  }

                  if (selectedMoveDate != null) {
                    filteredRooms = filteredRooms
                        .where((room) => room.moveInDate == selectedMoveDate)
                        .toList();
                  }

                  if (selectedOccupation != null) {
                    filteredRooms = filteredRooms
                        .where((room) => room.occupationPerRoom == selectedOccupation)
                        .toList();
                  }


                  if (filteredRooms.isEmpty) {
                    return const Center(child: Text('No rooms available'));
                  }
                  String query = searchController.text.toLowerCase();
                  if (query.isNotEmpty) {
                    filteredRooms = filteredRooms.where((room) => room.address.toLowerCase().contains(query)).toList();
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(width: 50,),
                                    // Save Button
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        saveRoom(room);
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
                                    SizedBox(width: 30,),
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
                                    SizedBox(width: 8,),
                               /*     ElevatedButton.icon(
                                      onPressed: () async {
                                        final String shareContent =
                                            'Check out this room:\nRoom Type: ${room.roomType}\nAddress: ${room.address}\nRent: ${room.roomRent}\nContact: ${room.mobileNumber}';

                                        final String whatsappUrl = 'whatsapp://send?text=$shareContent';

                                        // Check if WhatsApp is installed
                                        if (await canLaunch(whatsappUrl)) {
                                          await launch(whatsappUrl);
                                        } else {
                                          Get.snackbar(
                                            'Error',
                                            'WhatsApp is not installed',
                                            snackPosition: SnackPosition.TOP,
                                            backgroundColor: Colors.red.shade100,
                                            colorText: Colors.black,
                                            duration: Duration(seconds: 2),
                                          );
                                        }
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
                                    )*/
                                  ],
                                ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

}




