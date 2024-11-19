import 'package:flutter/material.dart';

class VoiceInputScreen extends StatelessWidget {
  static const String robot = "assets/icons/robot.png";
  static const String mic = "assets/icons/mic.png";
  static const String reload = "assets/icons/reload.png";
  static const String pause = "assets/icons/pause.png";
  static const String delete = "assets/icons/delete.png";

  const VoiceInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // Robot image and Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
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
                  const SizedBox(width: 10),
                  Image.asset(
                    robot,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Mic button with ripple animation
              GestureDetector(
                onTap: () {
                  // Handle voice recording
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    mic,
                    height: 250,
                    width: 250,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'TAP & SPEAK',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 20),

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
              const SizedBox(height: 30),

              // Done button
              ElevatedButton(
                onPressed: () {
                  // Handle Done action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB60F6E),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
