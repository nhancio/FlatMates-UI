
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controllers/room_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';


class RoomDetailScreen extends StatefulWidget {
  final Room room;

  RoomDetailScreen({required this.room});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<String> _imageUrls = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadRoomImages();


  }


  Future<void> _loadRoomImages() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;


      QuerySnapshot roomQuery = await firestore
          .collection('rooms')
          .where('address', isEqualTo: widget.room.address) // Match by userId
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
        backgroundColor: Color(0xfff8e6f1),

        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Color(0xFFB60F6E)),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation,
                    secondaryAnimation) =>
                    RoomList(),
                transitionsBuilder: (context, animation,
                    secondaryAnimation, child) {
                  var tween = Tween(
                      begin: const Offset(0.0, 0.0),
                      end: Offset.zero)
                      .chain(
                      CurveTween(curve: Curves.ease));
                  var offsetAnimation =
                  animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },),);          },
        ),
        title: const Text(
          'Room Details'
            ,style: TextStyle(color: Color(0xFFB60F6E))
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageUrls.isNotEmpty
                ? CarouselSlider.builder(
              itemCount: _imageUrls.length,
              itemBuilder: (context, index, realIndex) {
                return Stack(
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(), // Default circular progress
                          Icon(
                            Icons.image, // Your unique icon
                            size: 30,
                            color: Colors.blue, // Customize color as needed
                          ),
                        ],
                      ),
                    ),
                    Image.network(
                      _imageUrls[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 350,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Image is fully loaded
                        }
                        return Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                              Icon(
                                Icons.image, // Unique icon
                                size: 30,
                                color: Colors.blue, // Customize color
                              ),
                            ],
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            'Failed to load image.',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: 400, // Full height
                viewportFraction: 1.0, // Full width
                autoPlay: true, // Auto-scroll
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
              ),
            )
                : const Center(
              child: Text("No images available."),
            ),

            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: 'Room Type: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text: widget.room.roomType,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 11),
            RichText(
              text: TextSpan(
                text: 'Address: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:widget.room.address,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 11),
            RichText(
              text: TextSpan(
                text: 'Rent: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:widget.room.roomRent,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 11),
            RichText(
              text: TextSpan(
                text: 'Move-in Date: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:widget.room.moveInDate,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 11),
            RichText(
              text: TextSpan(
                text: 'Home Type: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:widget.room.homeType,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 11),
            RichText(
              text: TextSpan(
                text: 'Occupancy: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:widget.room.occupationPerRoom,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 11),
            RichText(
              text: TextSpan(
                text: 'Amenities: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:widget.room.selectedValues.join(", "),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 11),
            RichText(
              text: TextSpan(
                text: 'Security deposit: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:widget.room.securityDeposit,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 11),
            RichText(
              text: TextSpan(
                text: 'Brokerage: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:widget.room.brokerage,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 11),
            RichText(
              text: TextSpan(
                text: 'Setup Cost: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:widget.room.setup,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 11),
            RichText(
              text: TextSpan(
                text: 'Description: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:widget.room.description,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 11),
            RichText(
              text: TextSpan(
                text: 'Contact Number: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600, // Medium weight for label
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text:widget.room.mobileNumber,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal, // Normal weight for value
                      color: Color(0xff100f0f),
                    ),
                  ),
                ],
              ),
            ),



            const SizedBox(height: 24),
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
      width: double.infinity,
      height: 400,
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Icon(Icons.error));
      },
    );
  }
}



