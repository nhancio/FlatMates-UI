import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedback Form')),
      body: Padding(
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
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
