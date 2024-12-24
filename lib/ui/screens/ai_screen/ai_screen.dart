import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flutter/material.dart';

class VoiceInputScreen extends StatelessWidget {
  static const String robot = "assets/icons/robot.png";
  static const String mic = "assets/icons/mic.png";
  static const String reload = "assets/icons/reload.png";
  static const String pause = "assets/icons/pause.png";
  static const String delete = "assets/icons/delete.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI",style: TextStyle(color: Color(0xFFB60F6E)),),
      backgroundColor: Color(0xfff8e6f1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFB60F6E)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
              (route) => false,
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),

              // Robot image and Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Tell Us More\nAbout Your Requirements',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    robot,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Mic button with ripple animation
              GestureDetector(
                onTap: () {
                  // Handle voice recording
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    mic,
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              SizedBox(height: 2),

              Text(
                'TAP & SPEAK',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 20),

              // Control buttons: Reload, Pause, Delete
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Image.asset(reload, height: 40),
                    onPressed: () {
                      // Handle reload action
                    },
                  ),
                  IconButton(
                    icon: Image.asset(pause, height: 40),
                    onPressed: () {
                      // Handle pause action
                    },
                  ),
                  IconButton(
                    icon: Image.asset(delete, height: 40),
                    onPressed: () {
                      // Handle delete action
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Done button
              ElevatedButton(
                onPressed: () {
                  // Handle Done action
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB60F6E),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
