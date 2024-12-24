/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/models/userprofile.model.dart';
import 'package:get/get.dart';

class HomemateController extends GetxController {
  var homemates = <UserProfile>[]
      .obs; // Observable list for homemates (List of UserProfile)
  var isLoading = true.obs; // Observable for loading state
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    loadHomemates(); // Fetch homemates when the controller is initialized
  }

  Future<void> loadHomemates() async {
    try {
      isLoading.value = true;

      // Get current user's UID
      String currentUserId = auth.currentUser?.uid ?? '';

      if (currentUserId.isEmpty) {
        print('No user is signed in');
        return;
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var userCollection = await firestore.collection('users').get();

      homemates.value = userCollection.docs
          .where((doc) => doc.id != currentUserId) // Exclude current user
          .map((doc) {
        var userData = doc.data();
        return UserProfile.fromMap(userData); // Convert to UserProfile object
      }).toList();
    } catch (e) {
      print('Error loading users: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/models/userprofile.model.dart';
import 'package:get/get.dart';

class HomemateController extends GetxController {
  var homemates = <UserProfile>[].obs; // Observable list for homemates
  var isLoading = true.obs; // Loading state
  var isError = false.obs; // Error state
  var errorMessage = ''.obs; // Error message

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    loadHomemates(); // Fetch homemates on controller initialization
  }

  Future<void> loadHomemates() async {
    try {
      isLoading.value = true;
      isError.value = false;

      // Get current user's UID
      String currentUserId = _auth.currentUser?.uid ?? '';

      if (currentUserId.isEmpty) {
        throw Exception('No user is signed in.');
      }

      // Fetch data from Firestore
      QuerySnapshot userCollection = await _firestore.collection('users').get();

      // Map documents to UserProfile list and exclude the current user
      homemates.value = userCollection.docs
          .where((doc) => doc.id != currentUserId) // Exclude the current user
          .map((doc) => UserProfile.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      isError.value = true;
      errorMessage.value = 'Failed to load homemates: $e';
    } finally {
      isLoading.value = false;
    }
  }
}

