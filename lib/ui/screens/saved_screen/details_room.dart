import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class RoomDetailPage extends StatefulWidget {
  final Map<String, dynamic> roomData;

   RoomDetailPage({Key? key, required this.roomData}) : super(key: key);

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();

}

class _RoomDetailPageState extends State<RoomDetailPage> {
  List<String> _imageUrls = [];
  @override
  void initState() {
    super.initState();
    _loadRoomImages();

  }
  final Map<String, String> amenitiesMap = {
    "Fridge": "assets/amenities/fridge.png",
    "Washing Machine": "assets/amenities/washing.png",
    "Mattress": "assets/amenities/mattress.png",
    "Smart TV": "assets/amenities/tv.png",
    "Sofa": "assets/amenities/sofa.png",
    "Dining Table": "assets/amenities/dining.png",
    "AC": "assets/amenities/ac.png",
    "Water Purifier": "assets/amenities/water.png",
    "Geyser": "assets/amenities/geyser.png",
  };


  Future<void> _loadRoomImages() async {
    try {
      var firestore = FirebaseFirestore.instance;


      QuerySnapshot roomQuery = await firestore
          .collection('rooms')
          .where('address', isEqualTo: widget.roomData['address']) // Match by userId
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Go back to Home
        return false; // Prevent default back action (no dialog here)
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff8e6f1),
      
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Color(0xFFB60F6E)),
            onPressed: () {
             Navigator.of(context).pop();
      
                     },
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
                      text:widget.roomData['roomType'],
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
                      text:widget.roomData['address'],
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
                  text: 'City: ',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text:widget.roomData['addressType'],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
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
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text:widget.roomData['homeType'],
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
                      text:widget.roomData['roomRent'],
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
                      text:widget.roomData['roomMoveInDate'],
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
                      text:widget.roomData['roomOccupationPerRoom'],
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
          /*    RichText(
                text: TextSpan(
                  text: 'Amenities: ',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600, // Medium weight for label
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text:widget.roomData['roomSelectedValues'].join(", "),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal, // Normal weight for value
                        color: Color(0xff100f0f),
                      ),
                    ),
                  ],
                ),
              ),*/





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
                      text:widget.roomData['securityDeposit'],
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
                      text:widget.roomData['brokerage'],
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
                      text:widget.roomData['setupCost'],
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
                      text:widget.roomData['description'],
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
                      text:widget.roomData['roomMobileNumber'],
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

                ),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: (widget.roomData['roomSelectedValues'] as List<dynamic>).map((amenity) {
                  String amenityName = amenity.toString(); // Convert to string safely

                  return Container(
                    width: 80,
                    height: 100,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // Soft shadow
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          amenitiesMap[amenityName] ?? 'assets/placeholder.png',
                          width: 25, // Image width
                          height: 25, // Image height
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 6), // Space between image and text
                        Text(
                          amenityName,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
      
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final Uri phoneUrl = Uri.parse('tel:${widget.roomData['roomMobileNumber']}');
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
      ),
    );
  }
}
