/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve stored user input
    final List<Map<String, dynamic>> userInput = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stored Data',
          style: TextStyle(color: Colors.white),  // Set the text color to white
        ),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),  // Set the back arrow icon color to white
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: userInput.isEmpty
          ? Center(
        child: Text(
          "No data found",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: userInput.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(
                Icons.text_snippet,
                color: Colors.purple,
              ),
              title: Text(
                userInput[index]['input'] ?? 'No data',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
*/
