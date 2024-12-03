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
