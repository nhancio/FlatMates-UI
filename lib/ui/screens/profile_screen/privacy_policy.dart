import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff8e6f1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFB60F6E)),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BottomNavBarScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  var tween = Tween(begin: const Offset(0.0, 0.0), end: Offset.zero)
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
        title: Text('Privacy Policy', style: TextStyle(color: Color(0xFFB60F6E))),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HomeMates AI is a product of Nhancio Technologies Private Limited. We respect your privacy and are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildPrivacyPolicyItem('1. Information We Collect',
                  'When you use HomeMates AI, we collect the following types of data:\n\n'
                      '• Personal Information: Name, Mobile Number, Gender, Address, and Roommate Preferences.\n'
                      '• Authentication Data: Google Login credentials used to verify your identity.\n'
                      '• Usage Data: Details of your interactions with the platform, including room listings, searches, and messages.'),
              _buildPrivacyPolicyItem('2. How We Use Your Information',
                  'We use your data to:\n\n'
                      '• Provide and improve HomeMates AI services.\n'
                      '• Facilitate connections between users for roommate and room-sharing purposes.\n'
                      '• Ensure account security and prevent fraudulent activity.\n'
                      '• Send notifications regarding platform updates and relevant communications.'),
              _buildPrivacyPolicyItem('3. Data Storage and Security',
                  'All user data is securely stored in Firebase.\n\n'
                      'We implement industry-standard security measures to protect your data from unauthorized access, loss, or misuse.\n'
                      'However, we cannot guarantee absolute security, and users are advised to protect their account credentials.'),
              _buildPrivacyPolicyItem('4. Sharing of Information',
                  'We do not sell, trade, or rent your personal data. However, we may share data with:\n\n'
                      '• Other Users: To facilitate communication between room seekers and room listers.\n'
                      '• Legal Authorities: If required by law or to enforce our Terms and Conditions.\n'
                      '• Service Providers: Third-party services that help us operate and enhance HomeMates AI.'),
              _buildPrivacyPolicyItem('5. User Rights and Choices',
                  'You have the right to:\n\n'
                      '• Access, update, or delete your personal data within your account settings.\n'
                      '• Withdraw consent for data processing (which may limit access to our services).\n'
                      '• Contact us for any privacy-related concerns or data requests.'),
              _buildPrivacyPolicyItem('6. Cookies and Tracking Technologies',
                  'We may use cookies or similar technologies to:\n\n'
                      '• Improve user experience and platform performance.\n'
                      '• Analyze usage trends and enhance our services.\n'
                      'Users can manage cookie preferences through their browser settings.'),
              _buildPrivacyPolicyItem('7. Changes to This Privacy Policy',
                  'We may update this Privacy Policy from time to time.\n\n'
                      'Significant changes will be communicated via email or platform notifications.\n'
                      'Continued use of HomeMates AI after updates constitutes acceptance of the revised policy.'),
              _buildPrivacyPolicyItem('8. Contact Information',
                  'For any questions or concerns regarding this Privacy Policy, please contact us at hello@nhancio.com.'),
              SizedBox(height: 16),
              Text(
                'By using HomeMates AI, you acknowledge that you have read, understood, and agreed to this Privacy Policy.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacyPolicyItem(String title, String content) {
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
