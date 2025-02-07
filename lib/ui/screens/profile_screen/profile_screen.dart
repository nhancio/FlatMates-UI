import 'package:flatemates_ui/controllers/google_controller.dart';
import 'package:flatemates_ui/ui/screens/feedback/feedback.dart';
import 'package:flatemates_ui/ui/screens/list_my_room_screen/rooms_listing.dart';
import 'package:flatemates_ui/ui/screens/profile_screen/contact_us.dart';
import 'package:flatemates_ui/ui/screens/profile_screen/privacy_policy.dart';
import 'package:flatemates_ui/ui/screens/profile_screen/profile_intro.dart';
import 'package:flatemates_ui/ui/screens/profile_screen/term_condition.dart';
import 'package:flatemates_ui/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/bottom/bottom_bar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GoogleController signInController = Get.put(GoogleController());
  Future<void> _refresh() async {
    setState(() {});
  }


  Future<bool> _onWillPop(BuildContext context) async {
    // Show the confirmation dialog
    bool? closeApp = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Do you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog and return true to close the app
                Navigator.of(context).pop(true);
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog and return false to stay in the app
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    // If closeApp is true, allow the app to close
    return closeApp ?? false; // Default to false if null
  }
  @override
  Widget build(BuildContext context) {
    // Fetch user data when the screen is loaded
    signInController.fetchUserProfile();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Go back to Home
        return false; // Prevent default back action (no dialog here)
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile Details",  style: TextStyle(color: Color(0xFFB60F6E)),),
          backgroundColor: const Color(0xfff8e6f1),
          elevation: 0,
           automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              double profileImageSize = screenWidth < 600 ? 80 : 100;
              double cardPadding = screenWidth < 600 ? 16 : 24;
              double fontSize = screenWidth < 600 ? 16 : 20;
              return Obx(() {
                // Get the user profile from the controller
                var user = signInController.userProfile;

                // Display a loading spinner while fetching user data
                // if (user.value) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: cardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        // Profile Card
                        Container(
                          padding: EdgeInsets.all(cardPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: const Color(0xFFB60F6E), width: 2),
                          ),
                          child: InkWell(
                            onTap: () {
                              signInController.fetchUserProfile();
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      ProfileIntroScreen(),
                                  transitionsBuilder:
                                      (context, animation, secondaryAnimation, child) {
                                    var tween = Tween(
                                        begin: const Offset(0.0, 0.0), end: Offset.zero)
                                        .chain(CurveTween(curve: Curves.ease));
                                    var offsetAnimation = animation.drive(tween);
                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );

                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg', // Default image if not present
                                    height: profileImageSize,
                                    width: profileImageSize,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.value.userName,
                                        style: TextStyle(
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFB60F6E),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        user.value.userEmail,
                                        style: TextStyle(
                                          fontSize: fontSize - 2,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // More Options
                        // _buildSectionTitle('More', fontSize),

                        _buildOptionItem(
                            context, 'Manage your Listing', Icons.arrow_forward_ios,
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      RoomListingPage(),
                                  transitionsBuilder:
                                      (context, animation, secondaryAnimation, child) {
                                    var tween = Tween(
                                        begin: const Offset(0.0, 0.0), end: Offset.zero)
                                        .chain(CurveTween(curve: Curves.ease));
                                    var offsetAnimation = animation.drive(tween);
                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                         // Get.to(RoomListingPage());
                        }),

                        _buildOptionItem(
                            context, 'Feedback', Icons.feedback_outlined,
                            subtitle: 'Help Us To Improve More', onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  FeedbackPage(),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
                                var tween = Tween(
                                    begin: const Offset(0.0, 0.0), end: Offset.zero)
                                    .chain(CurveTween(curve: Curves.ease));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                         // Get.to(  FeedbackPage());
                        }),

                        _buildOptionItem(
                          context,
                          'Contact Us',
                          Icons.info,
                          subtitle: 'We are always here for you.',
                          onTap: () =>
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      ContactUsScreen(),
                                  transitionsBuilder:
                                      (context, animation, secondaryAnimation, child) {
                                    var tween = Tween(
                                        begin: const Offset(0.0, 0.0), end: Offset.zero)
                                        .chain(CurveTween(curve: Curves.ease));
                                    var offsetAnimation = animation.drive(tween);
                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              ),

                        ),

                        _buildOptionItem(
                          context,
                          'Terms and Conditions',
                          Icons.article_outlined,
                          subtitle: ' We are always here for you.',
                          onTap: () =>
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      TermsConditionsScreen(),
                                  transitionsBuilder:
                                      (context, animation, secondaryAnimation, child) {
                                    var tween = Tween(
                                        begin: const Offset(0.0, 0.0), end: Offset.zero)
                                        .chain(CurveTween(curve: Curves.ease));
                                    var offsetAnimation = animation.drive(tween);
                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              ),

                        ),
                        _buildOptionItem(
                          context,
                          'Privacy Policy',
                          Icons.privacy_tip_rounded,
                          subtitle: ' We are always here for you.',
                          onTap: () =>
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      PrivacyPolicyScreen(),
                                  transitionsBuilder:
                                      (context, animation, secondaryAnimation, child) {
                                    var tween = Tween(
                                        begin: const Offset(0.0, 0.0), end: Offset.zero)
                                        .chain(CurveTween(curve: Curves.ease));
                                    var offsetAnimation = animation.drive(tween);
                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              ),

                        ),
                        _buildOptionItem(context, 'Logout', Icons.logout,
                            subtitle: 'You can log in anytime.', onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Logout Confirmation'),
                                    content: Text('Are you sure you want to log out?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Close the dialog
                                          signInController.signOut();
                                          Get.offAll(() => WelcomeScreen()); // Navigate to WelcomeScreen
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),

                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, String title, IconData icon,
      {String? subtitle, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            )
          : null,
      trailing: Icon(icon, color: Colors.grey),
      onTap: onTap,
    );
  }
}
