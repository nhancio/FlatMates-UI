/*class RoomList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RoomControllerFirebase roomController =
    Get.put(RoomControllerFirebase());

    return Scaffold(
      body: Obx(() {
        // Observe the isLoading state
        if (roomController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if rooms are available
        if (roomController.rooms.isEmpty) {
          return const Center(child: Text('No rooms available'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: roomController.rooms.length,
          itemBuilder: (context, index) {
            final room = roomController.rooms[index];
            return Card(
              color: Colors.purple,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
               /* title: Text(
                  'Room Type: ${room.roomType}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),*/
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                               "assets/images/house.png",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Room Type: ${room.roomType}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('Address: ${room.address}',
                                  style: const TextStyle(color: Colors.white)),
                              Text('Rent: ${room.roomRent}',
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                   /* Text(
                      'Address: ${room.address}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Rent: ${room.roomRent}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Home Type: ${room.homeType}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Move-in Date: ${room.moveInDate}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Occupancy: ${room.occupationPerRoom}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),*/
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Save Button
                        ElevatedButton.icon(
                          onPressed: () {
                            // Implement save action
                          },
                          icon: const Icon(Iconsax.save_2),
                          label: const Text('Save'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.green.shade100, // Save button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                        ),
                        // Call Button
                        ElevatedButton.icon(
                          onPressed: () async {
                            final Uri _phoneUrl = Uri.parse('tel:${room.mobileNumber}');
                            try {
                              if (await canLaunchUrl(_phoneUrl)) {
                                await launchUrl(_phoneUrl);
                              } else {
                                throw 'Could not launch the dialer';
                              }
                            } catch (e) {
                              print('Could not launch the dialer: $e');
                            }
                          },
                          icon: const Icon(Iconsax.call),
                          label: Text('Call: ${room.mobileNumber}'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade100, // Call button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RoomDetailScreen(room: room),
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}*/

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RoomControllerFirebase extends GetxController {
  var rooms = <Room>[].obs; // Observable for room list
  var isLoading = true.obs; // Observable for loading state


  @override
  void onInit() {
    super.onInit();
    fetchRooms(); // Fetch room data when the controller is initialized
  }

  Future<void> fetchRooms() async {
    try {
      isLoading.value = true; // Start loading
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch data from Firestore
      QuerySnapshot snapshot = await firestore.collection('rooms').get();
      rooms.value = snapshot.docs.map((doc) {
        return Room.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching rooms: $e');
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}

class Room {
  final String address;
  final String homeType;
  final String moveInDate;
  final String occupationPerRoom;
  final String roomRent;
  final String roomType;
  final String userId;
  final String mobileNumber;

  Room({
    required this.address,
    required this.homeType,
    required this.moveInDate,
    required this.occupationPerRoom,
    required this.roomRent,
    required this.roomType,
    required this.userId,
    required this.mobileNumber,
  });

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      address: map['address'] ?? '',
      homeType: map['homeType'] ?? '',
      moveInDate: map['moveInDate'] ?? '',
      occupationPerRoom: map['occupationPerRoom'] ?? '',
      roomRent: map['roomRent'] ?? '',
      roomType: map['roomType'] ?? '',
      userId: map['userId'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
    );
  }
}
*/