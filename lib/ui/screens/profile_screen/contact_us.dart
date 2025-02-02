import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
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
          title: Text('Contact Us',   style: TextStyle(color: Color(0xFFB60F6E)),)),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Context',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.purple,
              //   ),
              // ),
              SizedBox(height: 16),
              Text(
                'Phone: +91-8247816401\n'
                'Email: hello@nhancio.com\n',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
