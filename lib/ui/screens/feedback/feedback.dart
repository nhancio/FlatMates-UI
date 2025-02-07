import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
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
            title: Text('Feedback Form',   style: TextStyle(color: Color(0xFFB60F6E)),)),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Your Name'),
                ),
                TextField(
                  controller: feedbackController,
                  decoration: InputDecoration(labelText: 'Your Feedback'),
                  maxLines: 4,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final name = nameController.text.trim();
                    final feedback = feedbackController.text.trim();
      
                    if (name.isNotEmpty && feedback.isNotEmpty) {
                      await FirebaseFirestore.instance.collection('feedbacks').add({
                        'name': name,
                        'feedback': feedback,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
      
                      nameController.clear();
                      feedbackController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Feedback submitted successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill out all fields.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB60F6E),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Submit Feedback',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
