import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../auth/auth_controller.dart';
import '../../../navigation/app_routes/routes.dart';
import '../../../res/assets/icons/icons.dart';
import '../../../res/dimensions/dimensions.dart';
import '../../../res/font/text_style.dart';
import '../../../widgets/custom_button/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final phoneController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Align to left
              children: [
                // Top Icon Bar
                SizedBox(
                  height: MediaQuery.of(context).size.height > 600 ? 60 : 100,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppIcons.icon, // App icon
                    height: 80, // Adjust the height as needed
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height > 600 ? 60 : 100,
                ),

                // Login/Register Title
                Text(
                  'Login/Register',
                  style: AppTextStyles.largeTitleStyle(context).copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: AppDimensions.extraLarge),

                // Description Text
                Text(
                  'By entering a valid phone number you can easily log in and get access to your account',
                  style: AppTextStyles.bodyStyle(context).copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: AppDimensions.extraLarge),

                // Responsive Phone Number Input with Flag and Down Arrow
                LayoutBuilder(
                  builder: (context, constraints) {
                    double inputWidth = constraints.maxWidth > 600
                        ? constraints.maxWidth * 0.3
                        : constraints.maxWidth * 0.85;

                    return Center(
                      child: SizedBox(
                        width: inputWidth,
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Enter Number',
                            hintStyle: const TextStyle(color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: AppDimensions.textFieldHeight / 2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Customize as needed
                            ),
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Image.asset(
                                    AppIcons.flag, // Country flag icon
                                    height: 24,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                ),
                                const VerticalDivider(
                                  width: 1,
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height > 600 ? 120 : 120,
                ),

                // Request OTP Button
                CustomButton(
                  text: 'Request OTP',
                  onPressed: () {
                    authController.phone.value = phoneController.text;
                    Get.toNamed(AppRoutes.verification);
                  },
                ),

                // Background Image (optional, can be used for decoration)
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Google Sign in',
                  onPressed: () async {
                    try {
                      // Call the function that may throw an error
                      await signInWithGoogle();
                      // await signInWithGoogle(context);
                    } catch (e) {
                      // Get.toNamed(AppRoutes
                      //     .verification);
                      //// If an error occurs, navigate to the error page
                    }
                  }, //todo:complete process
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Guest Sign in',
                  onPressed: () async {
                    try {
                      // Call the function that may throw an error
                      await signInAnonymously();
                      // await signInWithGoogle(context);
                    } catch (e) {
                      // Get.toNamed(AppRoutes
                      //     .verification);
                      //// If an error occurs, navigate to the error page
                    }
                  }, //todo:complete process
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential usercredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    // print(usercredential.user?.displayName);
  } // option 1

  signInAnonymously() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      if (userCredential.user != null) {
        print("👤 Successfully signed in anonymously!");
      }
    } catch (e) {
      print("⚠️ Failed to sign in anonymously: $e");
    }
    //WARNING: You are using the Auth Emulator, which is intended for local testing only.  Do not use with production credentials.
    //notethisisnotan error, rather informational messages
  }
// //Option 2
  // Future<void> signInWithGoogle(BuildContext context) async {
  //   try {
  //     // Attempt to sign in with Google
  //     GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //     // If the user cancels the sign-in, return early
  //     if (googleUser == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Sign-in canceled by user')),
  //       );
  //       return;
  //     }

  //     // Obtain the authentication details
  //     GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
  //     if (googleAuth == null) {
  //       throw Exception('Google Authentication failed');
  //     }

  //     // Create a new credential for Firebase Authentication
  //     AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Sign in to Firebase with the Google credentials
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);

  //     // Sign-in successful
  //     print('Signed in as ${userCredential.user?.displayName}');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Welcome ${userCredential.user?.displayName}!')),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     // Handle Firebase-specific errors
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Firebase Auth Error: ${e.message}')),
  //     );
  //     print('FirebaseAuthException: ${e.message}');
  //   } catch (e) {
  //     // Handle other errors
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('An error occurred: $e')),
  //     );
  //     print('Error: $e');
  //   }
  // }
}
