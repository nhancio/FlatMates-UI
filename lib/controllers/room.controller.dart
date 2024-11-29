import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/models/room.model.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  // Rx variables to observe changes
  var roomType = ''.obs;
  var homeType = ''.obs;
  var address = ''.obs;
  var roomRent = ''.obs;
  var moveInDate = ''.obs;
  var occupationPerRoom = ''.obs;
  var profileImages = <String>[].obs; // Store URLs or file paths for images
  // var moveInDate = Rx<DateTime?>(null); // To hold the selected date
  var roomDetails =
      Rxn<Room>(); // Assuming RoomModel is a class to store room data

  Future<void> fetchRoomDetails(String roomId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomId)
          .get();

      if (snapshot.exists) {
        roomDetails.value =
            Room.fromMap(snapshot.id, snapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch room details.');
    }
  }

  // Functions to handle data changes
  void setRoomType(String value) {
    roomType.value = value;
  }

  void setHomeType(String value) {
    homeType.value = value;
  }

  void setAddress(String value) {
    address.value = value;
  }

  void setRoomRent(String value) {
    roomRent.value = value;
  }

  void setMoveInDate(String value) {
    moveInDate.value = value;
    print(moveInDate);
  }

  void setOccupationPerRoom(String value) {
    occupationPerRoom.value = value;
  }

  void addProfileImage(String imageUrl) {
    if (profileImages.length < 3) {
      profileImages.add(imageUrl);
    } else {
      // Limit to 3 images
      Get.snackbar('Error', 'You can upload only 3 images.');
    }
  }

  void removeProfileImage(String imageUrl) {
    profileImages.remove(imageUrl);
  }

  // void setMoveInDate(DateTime? date) {
  //   moveInDate.value = date;
  // }

  // Function to submit room listing (e.g., to Firebase)
  // Submit room listing to Firestore
  Future<void> submitRoomListing() async {
    try {
      // Get current user UID
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // If the user is not authenticated
        print('User not authenticated');
        return;
      }

      // Create a new room document in Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference rooms = firestore.collection('rooms');

      // Prepare the room data
      Map<String, dynamic> roomData = {
        'roomType': roomType.value,
        'homeType': homeType.value,
        'address': address.value,
        'roomRent': roomRent.value,
        'moveInDate': moveInDate.value,
        'occupationPerRoom': occupationPerRoom.value,
        'userId': user.uid, // Store the user's UID
        'createdAt': FieldValue
            .serverTimestamp(), // Timestamp of the room listing creation
      };

      // Add the data to Firestore
      await rooms.add(roomData);
      Get.back();
    } catch (e, stackTrace) {
      print('Error submitting room listing: $e');
      print(stackTrace);
    }
  }

  var rooms = <Room>[].obs;

  // Load rooms from Firestore
  Future<void> loadRooms() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var roomCollection = await firestore.collection('rooms').get();

      rooms.value = roomCollection.docs
          .map((doc) => Room.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print(e.toString());
    }
  }

  // Save room to Firestore (when editing or adding)
  Future<void> saveRoom(Room room) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('rooms').doc(room.id).set(room.toMap());
  }

  // Update room details (for editing)
  void updateRoom(Room room) {
    var index = rooms.indexWhere((r) => r.id == room.id);
    if (index != -1) {
      rooms[index] = room;
    }
  }

  // Add a new room to Firestore
  Future<void> addRoom(Room room) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var docRef = await firestore.collection('rooms').add(room.toMap());
    room.id = docRef.id;
    rooms.add(room);
  }
}
