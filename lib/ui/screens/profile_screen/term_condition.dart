import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfff8e6f1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Color(0xFFB60F6E),),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BottomNavBarScreen(),
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
          ),
          title: Text('Terms and Conditions',   style: TextStyle(color: Color(0xFFB60F6E)),)),

      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to HomeMates AI! By using our platform, you agree to comply with the following Terms and Conditions. Please read them carefully.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildTermsItem('1. Acceptance of Terms', 'By accessing or using HomeMates AI, you agree to these Terms and Conditions, as well as our Privacy Policy. If you do not agree, please do not use our services.'),
              _buildTermsItem('2. User Registration & Account',
                  'You must log in using Google authentication to access HomeMates AI.\nYou agree to provide accurate and complete details, including your Name, Mobile Number, Gender, Address, and Roommate Preferences.\nYou are responsible for maintaining the confidentiality of your login credentials.\nHomeMates AI is not responsible for any unauthorized access to your account.'),
              _buildTermsItem('3. Listing & Searching for Rooms',
                  'Users can list available rooms and provide details for potential roommates.\nHomeMates AI acts as a platform to connect users but does not guarantee the accuracy, availability, or security of listed properties.\nUsers are responsible for verifying the authenticity of listings and engaging with potential roommates at their own discretion.'),
              _buildTermsItem('4. User Responsibilities',
                  'You agree to use HomeMates AI for lawful purposes only.\nYou shall not post false, misleading, or offensive content.\nYou are responsible for all interactions and communications with other users.\nHomeMates AI is not liable for any disputes, damages, or losses arising from user interactions.'),
              _buildTermsItem('5. Data Collection & Privacy',
                  'Your data, including personal details and preferences, is securely stored in Firebase.\nBy using the platform, you consent to the collection and processing of your data as per our Privacy Policy.\nHomeMates AI takes necessary security measures but does not guarantee absolute protection from data breaches.'),
              _buildTermsItem('6. Prohibited Activities',
                  'Misuse of the platform, including fraud, harassment, or spamming, is strictly prohibited.\nAny attempt to manipulate the platform’s features for unauthorized purposes may result in account suspension or legal action.'),
              _buildTermsItem('7. Limitation of Liability',
                  'HomeMates AI is a platform that facilitates connections but does not assume responsibility for any agreements, disputes, or damages arising from user interactions.\nWe are not liable for any losses incurred due to inaccurate listings or misrepresentation by users.'),
              _buildTermsItem('8. Changes to Terms',
                  'We reserve the right to update these Terms and Conditions at any time.\nUsers will be notified of significant changes, and continued use of the platform constitutes acceptance of the updated terms.'),
              _buildTermsItem('9. Termination of Services',
                  'HomeMates AI reserves the right to suspend or terminate any user account at its discretion for violations of these terms.'),
              _buildTermsItem('10. Contact Information',
                  'For any questions or concerns regarding these Terms and Conditions, please contact us at hello@nhancio.com.\nHomeMates AI is a product of Nhancio Technologies Private Limited. All rights reserved.'),
              SizedBox(height: 16),
              Text(
                'By using HomeMates AI, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text(content, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}