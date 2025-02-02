import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flatemates_ui/widgets/routes_get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreferenceController extends GetxController {
  // Method to save preferences to Firestore
  Future<void> savePreferences(List<String> selectedPreferences) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print('User not authenticated');
        return;
      }

      // Get the Firestore user document reference
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDoc = firestore.collection('users').doc(user.uid);

      // Update preferences in Firestore under the user document
      await userDoc.update({
        'preferences': selectedPreferences,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('Preferences saved successfully!');
      // Navigate to the next screen after saving preferences
      // Get.toNamed('/nextScreen');
      //Get.to(BottomNavBarScreen());
      Navigator.of(Get.context!).push(CustomWidgetTransition(page: BottomNavBarScreen()));
    } catch (e) {
      print('Error saving preferences: $e');
    }
  }
}
