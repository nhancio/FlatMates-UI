import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;

  CustomButton1({required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(title),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: TextStyle(fontSize: 16),
      ),
    );
  }
}
/*<!DOCTYPE html>
<html>
<head>
  <base href="$FLUTTER_BASE_HREF">

  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="A new Flutter project.">

  <!-- iOS meta tags & icons -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="flatmates">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <!-- Favicon -->
  <link rel="icon" type="image/png" href="favicon.png"/>

  <title>flatmates</title>
  <link rel="manifest" href="manifest.json">

  <!-- Firebase SDKs -->
  <script src="https://www.gstatic.com/firebasejs/9.1.0/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/9.1.0/firebase-analytics.js"></script>
  <script src="https://www.gstatic.com/firebasejs/9.1.0/firebase-auth.js"></script>

  <script>
    // Your web app's Firebase configuration
    const firebaseConfig = {
      apiKey: "AIzaSyDUV7-llujPdHhTLRuZBiIm7jGKy4eGgP0",
      authDomain: "homemates-ai.firebaseapp.com",
      projectId: "homemates-ai",
      storageBucket: "homemates-ai.appspot.com",
      messagingSenderId: "236958118893",
      appId: "1:236958118893:web:9e804cd07251c72327ade4",
      measurementId: "G-FCDYBFYPDS"
    };

    // Initialize Firebase
    const app = firebase.initializeApp(firebaseConfig);
    const analytics = firebase.analytics(app);
  </script>
</head>
<body>
<!-- Recaptcha container for Firebase Authentication -->
<div id="recaptcha-container"></div>

<script src="flutter_bootstrap.js" async></script>
</body>
</html>import 'package:firebase_core/firebase_core.dart';
import 'package:flatmates/Jay/navigation/app_routes/routes.dart';
import 'package:flatmates/Jay/res/font/font_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


const FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyDUV7-llujPdHhTLRuZBiIm7jGKy4eGgP0",

    projectId: "homemates-ai",
    storageBucket: "homemates-ai.appspot.com",
    messagingSenderId: "236958118893",
    appId: "1:236958118893:web:9e804cd07251c72327ade4",
    authDomain: "homemates-ai.firebaseapp.com",
    measurementId: "G-FCDYBFYPDS"
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions); // Initialize Firebase with options
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeMates App',
      theme: ThemeData(
        fontFamily: AppFonts.familyPoppins,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
      initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.routes,
    );
  }
}import 'package:flatmates/Jay/auth/auth_controller.dart';
import 'package:flatmates/Jay/widgets/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VerificationScreen extends StatefulWidget {
  final String verificationId;

  VerificationScreen({required this.verificationId});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers =
  List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index].unfocus();
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _verifyOTP() {
    String otpCode = _controllers.map((c) => c.text).join('');
    if (otpCode.length == 6) {  // Ensure OTP length is 6
      authController.otpCode.value = otpCode;
      authController.verifyUser(widget.verificationId);
    } else {
      Get.snackbar('Error', 'Please enter a valid 6-digit code');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verification Code',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Enter the 6-digit code sent to ${authController.phone.value}.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: List.generate(6, (index) => _buildOTPBox(index)),
            ),
            SizedBox(height: 20),
            Obx(() {
              return authController.isLoading.value
                  ? CircularProgressIndicator()
                  : CustomButton(
                text: 'Verify',
                onPressed: _verifyOTP,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPBox(int index) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        style: TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) => _onChanged(index, value),
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
      ),
    );
  }
}import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatmates/Jay/ui/screens/verify_otp_screen/verification_otp.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final otpCode = ''.obs;
  final phone = ''.obs; // Store the phone number for verification
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs; // Loading state

  Future<void> sendOTP(String phoneNumber) async {
    isLoading.value = true; // Start loading
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in if verification is completed
          await _auth.signInWithCredential(credential);
          isLoading.value = false; // Stop loading
          Get.snackbar('Success', 'Phone number verified successfully');
        },
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false; // Stop loading
          print("Firebase Error Code: ${e.code}");
          print("Firebase Error Message: ${e.message}");
          Get.snackbar('Error', e.message ?? 'Verification failed');
        },

        codeSent: (String verificationId, int? resendToken) {
          isLoading.value = false; // Stop loading
          Get.snackbar('OTP Sent', 'Check your phone for the OTP.');
          Get.to(() => VerificationScreen(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          isLoading.value = false; // Stop loading
        },
        timeout: const Duration(minutes: 2),
      );
    } catch (e) {
      isLoading.value = false; // Stop loading
      print("Exception: $e"); // Print any other exceptions
      Get.snackbar('Error', 'Failed to send OTP: $e');
    }
  }

  void verifyUser(String verificationId) async {
    isLoading.value = true; // Start loading
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode.value,
      );
      await _auth.signInWithCredential(credential);
      isLoading.value = false; // Stop loading
      Get.snackbar('Success', 'Phone number verified successfully');
    } catch (e) {
      isLoading.value = false; // Stop loading
      print("Exception: $e"); // Print detailed error if OTP verification fails
      Get.snackbar('Error', 'OTP Verification failed: $e');
    }
  }
}import 'package:flatmates/Jay/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final phoneController = TextEditingController(text: '+91'); // Start with +91

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/app_icon.png', height: 80),
                const SizedBox(height: 20),
                Text(
                  'Login/Register',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter a valid phone number to log in.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Enter Number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                Obx(() {
                  return ElevatedButton(
                    onPressed: authController.isLoading.value
                        ? null
                        : () async {
                      String phoneNumber = phoneController.text.trim();
                      // Validate phone number
                      if (phoneNumber.length > 3) { // Ensure user input follows the correct format
                        authController.phone.value = phoneNumber; // Use the entire phone number
                        await authController.sendOTP(authController.phone.value);
                      } else {
                        Get.snackbar('Error', 'Enter a valid phone number');
                      }
                    },
                    child: authController.isLoading.value
                        ? CircularProgressIndicator()
                        : Text('Send OTP'),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/