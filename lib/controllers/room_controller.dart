
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
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
  /* Future<void> fetchSavedRooms() async {
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
}*/
  Future<void> fetchSavedRooms(String userId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('saved_Rooms')
          .doc(userId)
          .collection('savedRooms')
          .get();

      if (querySnapshot.docs.isEmpty) {
        print("No saved rooms found.");
        return;
      }

      // Map Firestore data to a list of Room objects
      savedRooms.value = querySnapshot.docs.map((doc) {
        return Room.fromMap(doc.data());
      }).toList();

      print("Fetched ${savedRooms.value.length} saved rooms.");
    } catch (e) {
      print('Error fetching saved rooms: ${e.toString()}');
    }
  }



  // Delete a saved room from Firebase
  // Define the deleteRoom function





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
  final String securityDeposit;
  final String brokerage;
  final String setup;
  final String description;
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
    required this.securityDeposit,
    required this.brokerage,
    required this.setup,
    required this.description,


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
      'securityDeposit': securityDeposit,
      'setupCost': setup,
      'brokerage': brokerage,
      'description': description,

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
      securityDeposit: map['securityDeposit'] ?? '',
      setup: map['setupCost'] ?? '',
      brokerage: map['brokerage'] ?? '',
      description: map['description'] ?? '',
      selectedValues: List<String>.from(map['selectedValues'] ?? []),
      profileImages: List<String>.from(map['profileImages'] ?? []),


    );
  }
}


