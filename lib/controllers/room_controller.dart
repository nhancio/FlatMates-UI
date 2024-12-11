import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RoomControllerFirebase extends GetxController {
  var rooms = <Room>[].obs; // Observable for room list
  var isLoading = true.obs; // Observable for loading state

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
}

class Room {
  final String address;
  final String homeType;
  final String moveInDate;
  final String occupationPerRoom;
  final String roomRent;
  final String roomType;
  final String userId;

  Room({
    required this.address,
    required this.homeType,
    required this.moveInDate,
    required this.occupationPerRoom,
    required this.roomRent,
    required this.roomType,
    required this.userId,
  });

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      address: map['address'] ?? '',
      homeType: map['homeType'] ?? '',
      moveInDate: map['moveInDate'] ?? '',
      occupationPerRoom: map['occupationPerRoom'] ?? '',
      roomRent: map['roomRent'] ?? '',
      roomType: map['roomType'] ?? '',
      userId: map['userId'] ?? '',
    );
  }
}
