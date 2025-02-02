

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/controllers/register.controller.dart';
import 'package:flatemates_ui/models/userprofile.model.dart';
import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flatemates_ui/ui/screens/register_yourself_screen/register_yourself.dart';
import 'package:flatemates_ui/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/routes_get.dart';

class GoogleController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var isLoading = false.obs;
  var buttonWidth = 200.0.obs; // Initial width for the button
  var isLoggedIn = false.obs;
  final RegisterUserController registerCtrl = Get.put(RegisterUserController());
  // Rx<UserProfile> userProfile = UserProfile().obs;
  var user = Rx<User?>(null); // Observable user variable
  Rx<UserProfile> userProfile = UserProfile().obs;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();();
  }

  // Check if the user is already logged in
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
    isLoggedIn.value = loggedIn;
    if (loggedIn && _auth.currentUser != null) {

      Get.offAll(() => BottomNavBarScreen());

    } else {

      Get.offAll(() => WelcomeScreen());

    }

  }

  // Google Sign-In method
  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    buttonWidth.value = 100.0; // Shrink button
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null)

        return;


      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _saveLoginStatus(true);

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      user.value = userCredential.user; // Update the user observable
      await saveLoginStatus(true); // Save the login status to SharedPreferences
      registerCtrl.nameController.text = userCredential.user?.displayName ?? "";
      registerCtrl.emailController.text = userCredential.user?.email ?? "";
      registerCtrl.phoneController.text =
          userCredential.user?.phoneNumber ?? "";
      checkUserAndNavigate();
    } catch (e) {
      print("Error during Google sign-in: $e");
    } finally {
      buttonWidth.value = 200.0; // Restore button size
      isLoading.value = false;
    }
  }

  // Sign-out method
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    await saveLoginStatus(false);
    isLoggedIn.value = false;
    user.value = null; // Reset user to null
  }

  // Save the login status to SharedPreferences
  Future<void> saveLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }



  Future<void> saveProfile({
    required String gender,
    required int age,
    required String location,
    required String foodChoice,
    required String drinking,
    required String smoking,
    required String pet,
    required List<String> preferences,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Map<String, dynamic> updatedData = {
          'gender': gender,
          'age': age,
          'location': location,
          'foodChoice': foodChoice,
          'drinking': drinking,
          'smoking': smoking,
          'pet': pet,
          'preferences': preferences,
          'updatedAt': FieldValue.serverTimestamp(),
        };

        // Save the updated profile to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update(updatedData);
        Get.back();
        Get.snackbar('Success', 'Profile updated successfully!');
      } else {
        Get.snackbar('Error', 'No user is logged in.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }

  // Check if user is signed in
  User? get currentUser => user.value;

  Future<void> checkUserAndNavigate() async {
    final user = FirebaseAuth.instance.currentUser;

    // Check if the user is logged in
    if (user == null) {
      // If there's no user, navigate to Register Screen
     // Get.to(RegisterUserScreen());
      Navigator.of(Get.context!).push(CustomWidgetTransition(page: RegisterUserScreen()));
      return;
    }

    // User is logged in, now check if the user profile exists in Firestore
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users') // Your Firestore collection name
          .doc(user.uid) // Use the current user's UID to check
          .get();

      if (!userDoc.exists) {
        // User doesn't exist in the Firestore collection, navigate to Register Screen
       // Get.to(RegisterUserScreen());
        Navigator.of(Get.context!).push(CustomWidgetTransition(page: RegisterUserScreen()));
      } else {
        // User exists in Firestore, navigate to Home Screen
      //  Get.to(BottomNavBarScreen());
        Navigator.of(Get.context!).push(CustomWidgetTransition(page: BottomNavBarScreen()));
      }
    } catch (e) {
      print('Error checking user: $e');
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      // Get the current user UID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users') // Assuming you have a 'users' collection
          .doc(userId)
          .get();

      // Check if user data exists
      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        userProfile.value = UserProfile.fromMap(
            data); // Convert the map to a UserProfile object
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _saveLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }
}



