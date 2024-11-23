import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flatemates_ui/ui/screens/register_yourself_screen/register_yourself.dart';
import 'package:flatemates_ui/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var isLoading = false.obs;
  var buttonWidth = 200.0.obs; // Initial width for the button
  var isLoggedIn = false.obs;

  var user = Rx<User?>(null); // Observable user variable

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  // Check if the user is already logged in
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
    isLoggedIn.value = loggedIn;
    if (loggedIn) {
      Get.to(BottomNavBarScreen());
    } else {
      Get.to(WelcomeScreen());
    }
  }

  // Google Sign-In method
  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    buttonWidth.value = 100.0; // Shrink button
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      user.value = userCredential.user; // Update the user observable
      await saveLoginStatus(true); // Save the login status to SharedPreferences
      Get.to(RegisterUserScreen());
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

  // Check if user is signed in
  User? get currentUser => user.value;
}
