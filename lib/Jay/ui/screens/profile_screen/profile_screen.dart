import 'package:flatmates/Jay/ui/screens/profile_screen/contact_us.dart';
import 'package:flatmates/Jay/ui/screens/profile_screen/profile_intro.dart';
import 'package:flatmates/Jay/ui/screens/profile_screen/rental_agreement_screen.dart';
import 'package:flatmates/Jay/ui/screens/profile_screen/rental_receipt_screen.dart';
import 'package:flatmates/Jay/ui/screens/profile_screen/tenant_verification_screen.dart';
import 'package:flatmates/Jay/ui/screens/profile_screen/term_condition.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double profileImageSize = screenWidth < 600 ? 80 : 100;
          double cardPadding = screenWidth < 600 ? 16 : 24;
          double fontSize = screenWidth < 600 ? 16 : 20;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Card
                  Container(
                    padding: EdgeInsets.all(cardPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.purple, width: 2),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileIntroScreen()));
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/icons/danile.png',
                              height: profileImageSize,
                              width: profileImageSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Danial Dan',
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Male | 0987654321',
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
                  SizedBox(height: 20),

                  // More Options
                  _buildSectionTitle('More', fontSize),
                  _buildOptionItem(
                      context, 'Manage your Listing', Icons.arrow_forward_ios,
                      onTap: () {}),
                  _buildOptionItem(context, 'About Us', Icons.info_outline,
                      subtitle: 'Know who we are and what we are doing.',
                      onTap: () {}),

                  _buildOptionItem(context, 'Feedback', Icons.feedback_outlined,
                      subtitle: 'Help Us To Improve More', onTap: () {}),

                  _buildOptionItem(
                    context,
                    'Contact Us',
                    Icons.info,
                    subtitle: 'We are always here for you.',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactUsScreen()),
                    ),
                  ),

                  _buildOptionItem(
                    context,
                    'Terms and Conditions',
                    Icons.article_outlined,
                    subtitle: ' We are always here for you.',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsConditionsScreen()),
                    ),
                  ),
                  SizedBox(height: 20),
                  // _buildOptionItem(
                  //   context,
                  //   'Rental Agreement',
                  //   Icons.description_outlined,
                  //   onTap: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => RentalAgreementScreen()),
                  //   ),
                  // ),
                  // _buildOptionItem(
                  //   context,
                  //   'Tenant Verification',
                  //   Icons.check_circle_outline,
                  //   onTap: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => TenantVerificationScreen()),
                  //   ),
                  // ),
                  // _buildOptionItem(
                  //   context,
                  //   'Rental Receipt',
                  //   Icons.receipt_long,
                  //   onTap: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => RentalReceiptScreen()),
                  //   ),
                  // ),

                  _buildOptionItem(context, 'Logout', Icons.logout,
                      subtitle: 'You can log in anytime.', onTap: () {}),
                ],
              ),
            ),
          );
        },
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
      contentPadding: EdgeInsets.symmetric(vertical: 8),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
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

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Log Out'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          ElevatedButton(
            child: Text('Yes'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              // Perform the logout action here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You have been logged out.')),
              );
            },
          ),
        ],
      );
    },
  );
}
