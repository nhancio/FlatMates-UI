import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flatemates_ui/models/room.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RoomController extends GetxController {
  // Address Package
  var buildingName = ''.obs;
  var locality = ''.obs;
  var city = ''.obs;

  // Property Details
  var homeType = ''.obs;
  var furnishType = ''.obs;
  var roomsAvailable = ''.obs;
  var roomType = ''.obs;
  var washroomType = ''.obs;
  var parkingType = ''.obs;
  var societyType = ''.obs;
  var moveInDate = ''.obs;
  var occupationPerRoom = ''.obs;
  var roomRent = ''.obs;

  // Additional fields for setup costs
  var securityDeposit = ''.obs;
  var brokerage = ''.obs;
  var setupCost = ''.obs;
  var description = ''.obs;

  // Tenant Preferences
  var preferredTenant = ''.obs;
  var tenantPreferences = <String>[].obs;

  // Contact Info
  var ownerName = ''.obs;
  var mobileNumber = ''.obs;

  // Other existing variables
  var profileImages = <String>[].obs;
  var roomDetails = Rxn<Room>();
  var selectedValues = <String>[].obs;
  var amenities = <String>[].obs;
  var imageUrls = <String>[].obs;

  // Additional Bills
  var wifiBill = '0'.obs;
  var waterBill = '0'.obs;
  var gasBill = '0'.obs;
  var maidCost = '0'.obs;
  var cookCost = '0'.obs;
  var otherCosts = '0'.obs;

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

  void updateSelectedValues(List<String> values) {
    selectedValues.assignAll(values); // Assign the entire list
  }


  // Functions to handle data changes
  void setRoomType(String value) {
    roomType.value = value;
  }

  void setHomeType(String value) {
    homeType.value = value;
  }

  // Remove setAddressType and setAddress methods since we now use buildingName, locality, and city

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

  void setMobileNumber(String value) {
    mobileNumber.value = value;
  }


  void addProfileImage(String imageUrl) {
    if (profileImages.length < 5) {
      profileImages.add(imageUrl);
    } else {
      // Limit to 3 images
      Get.snackbar('Error', 'You can upload only 5 images.');
    }
  }

  void removeProfileImage(String imageUrl) {
    profileImages.remove(imageUrl);
  }
  void setSecurityDeposit(String value) {
    securityDeposit.value = value;
  }

  void setBrokerage(String value) {
    brokerage.value = value;
  }

  void setSetupCost(String value) {
    setupCost.value = value;
  }

  void setDescription(String value) {
    description.value = value;
  }

  void setWifiBill(String value) {
    wifiBill.value = value;
  }

  void setWaterBill(String value) {
    waterBill.value = value;
  }

  void setGasBill(String value) {
    gasBill.value = value;
  }

  void setMaidCost(String value) {
    maidCost.value = value;
  }

  void setCookCost(String value) {
    cookCost.value = value;
  }

  void setOtherCosts(String value) {
    otherCosts.value = value;
  }

  // Setter methods for new fields
  void setBuildingName(String value) => buildingName.value = value;
  void setLocality(String value) => locality.value = value;
  void setCity(String value) => city.value = value;
  void setFurnishType(String value) => furnishType.value = value;
  void setRoomsAvailable(String value) => roomsAvailable.value = value;
  void setWashroomType(String value) => washroomType.value = value;
  void setParkingType(String value) => parkingType.value = value;
  void setSocietyType(String value) => societyType.value = value;
  void setPreferredTenant(String value) => preferredTenant.value = value;
  void setOwnerName(String value) => ownerName.value = value;

  void updateTenantPreferences(List<String> values) {
    tenantPreferences.assignAll(values);
  }

  void updateAmenities(List<String> values) {
    amenities.assignAll(values);
  }

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
        'buildingName': buildingName.value,
        'locality': locality.value,
        'city': city.value,
        'homeType': homeType.value,
        'furnishType': furnishType.value,
        'roomsAvailable': roomsAvailable.value,
        'roomType': roomType.value,
        'washroomType': washroomType.value,
        'parkingType': parkingType.value,
        'societyType': societyType.value,
        'moveInDate': moveInDate.value,
        'occupationPerRoom': occupationPerRoom.value,
        'roomRent': roomRent.value,
        'preferredTenant': preferredTenant.value,
        'tenantPreferences': tenantPreferences.toList(),
        'ownerName': ownerName.value,
        'mobileNumber': mobileNumber.value,
        'userId': user.uid, // Store the user's UID
        'selectedValues': selectedValues.toList(), // Store selected values (single or multiple)
        'createdAt': FieldValue
            .serverTimestamp(), // Timestamp of the room listing creation
        'images': imageUrls,
        'securityDeposit': securityDeposit.value,
        'brokerage': brokerage.value,
        'setupCost': setupCost.value,
        'description': description.value,
        'wifiBill': wifiBill.value,
        'waterBill': waterBill.value,
        'gasBill': gasBill.value,
        'maidCost': maidCost.value,
        'cookCost': cookCost.value,
        'otherCosts': otherCosts.value,
      };
   //   await FirebaseFirestore.instance.collection('rooms').add(roomData);
      await rooms.add(roomData);
    //  Get.snackbar('Success', 'Room listing added successfully!');
      Get.snackbar(
        'Success',
        'Room listing added successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey.shade100,
        colorText: Colors.black,
        duration: Duration(seconds: 2),
      );
      // Add the data to Firestore

      Get.back();
    } catch (e, stackTrace) {
      Get.snackbar(
        'Error',
        'Error submitting room listing',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
        duration: Duration(seconds: 3),
      );
      print('Error submitting room listing: $e');
      print(stackTrace);
    }
  }

  var rooms = <Room>[].obs;

  // Load rooms from Firestore
  Future<void> loadMyRooms() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseAuth auth = FirebaseAuth.instance;

      // Get the current user's UID
      String currentUserId = auth.currentUser?.uid ?? '';

      // If the user is not authenticated, return early
      if (currentUserId.isEmpty) {
        print('No user is signed in');
        return;
      }

      // Fetch rooms where the userId matches the current user's ID
      var roomCollection = await firestore
          .collection('rooms')
          .where('userId', isEqualTo: currentUserId)
          .get();

      // Map the fetched documents to Room objects
      rooms.value = roomCollection.docs
          .map((doc) => Room.fromMap(doc.id, doc.data()))
          .toList();

      print('Rooms loaded successfully');
    } catch (e) {
      print('Error loading rooms: ${e.toString()}');
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


