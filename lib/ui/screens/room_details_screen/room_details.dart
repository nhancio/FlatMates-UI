


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/room_controller.dart';
import '../../../res/bottom/bottom_bar.dart';

class RoomDetailScreen extends StatelessWidget {
  final Room room;


  RoomDetailScreen({required this.room,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff8e6f1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Room Detail',
          style: TextStyle(
              color: Colors.purple, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Room Type: ${room.roomType}',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text('Address: ${room.address}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Rent: ${room.roomRent}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Move-in Date: ${room.moveInDate}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Occupancy: ${room.occupationPerRoom}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('ABc: ${room.selectedValues}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Contact Number: ${room.mobileNumber}',
                style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 16),
            Center(
              child:  ElevatedButton(
                onPressed: () async {
                  final Uri phoneUrl = Uri.parse('tel:${room.mobileNumber}');
                  try {
                    if (await canLaunchUrl(phoneUrl)) {
                      await launchUrl(phoneUrl);
                    } else {
                      throw 'Could not launch the dialer';
                    }
                  } catch (e) {
                    print('Error launching dialer: $e');
                  }
                },
                child: const Text('Call', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB60F6E),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

