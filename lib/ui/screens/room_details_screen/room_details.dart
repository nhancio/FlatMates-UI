import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/room_controller.dart';
import '../../../res/bottom/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui' as ui;
import 'dart:html' as html;

class RoomDetailScreen extends StatefulWidget {
  final Room room;

  RoomDetailScreen({required this.room});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _loadRoomImages();
  }

  Future<void> _loadRoomImages() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query the room based on the userId field
      QuerySnapshot roomQuery = await firestore
          .collection('rooms')
          .where('userId', isEqualTo: widget.room.userId) // Match by userId
          .get();

      // If rooms exist for the user, fetch the first document
      if (roomQuery.docs.isNotEmpty) {
        Map<String, dynamic> roomData =
        roomQuery.docs.first.data() as Map<String, dynamic>;

        // Extract the images
        setState(() {
          _imageUrls = List<String>.from(roomData['images'] ?? []);
        });
      } else {
        print('No rooms found for the given userId');
      }
    } catch (e) {
      print('Error loading room images: ${e.toString()}');
    }
  }


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
              'Room Type: ${widget.room.roomType}',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text('Address: ${widget.room.address}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Rent: ${widget.room.roomRent}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Move-in Date: ${widget.room.moveInDate}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Occupancy: ${widget.room.occupationPerRoom}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('ABc: ${widget.room.selectedValues}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Contact Number: ${widget.room.mobileNumber}', style: const TextStyle(fontSize: 16)),

            _imageUrls.isNotEmpty
                ? Wrap(
              spacing: 8.0,
              children: _imageUrls.map((url) {
                return _buildImage(url);
              }).toList(),
            )
                : const Center(child: Text("No images available.")),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final Uri phoneUrl = Uri.parse('tel:${widget.room.mobileNumber}');
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

  Widget _buildImage(String url) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: 100,
      height: 100,
      errorBuilder: (context, error, stackTrace) {
        return Center(child: Icon(Icons.error));
      },
    );
  }
}




/*


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
*/

