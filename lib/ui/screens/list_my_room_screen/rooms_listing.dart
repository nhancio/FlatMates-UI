import 'package:flatemates_ui/controllers/room.controller.dart';
import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flatemates_ui/ui/screens/list_my_room_screen/edit_room.dart';
import 'package:flatemates_ui/ui/screens/list_my_room_screen/list_my_room.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomListingPage extends StatefulWidget {
  @override
  State<RoomListingPage> createState() => _RoomListingPageState();
}

class _RoomListingPageState extends State<RoomListingPage> {
  final RoomController roomController = Get.put(RoomController());

  @override
  void initState() {
    super.initState();
    roomController.loadMyRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Color(0xFFB60F6E),),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBarScreen()));
          },
        ),
        backgroundColor: const Color(0xfff8e6f1),
        title: const Text('Room Listings',
            style: TextStyle(color: Color(0xFFB60F6E))),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Color(0xFFB60F6E),
            ),
            onPressed: () {
              // Navigate to EditRoomPage for adding a new room
              Get.to(() => const AddRoomPage());
            },
          )
        ],
      ),
      body: Obx(() {
        if (roomController.rooms.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: roomController.rooms.length,
          itemBuilder: (context, index) {
            final room = roomController.rooms[index];
            return GestureDetector(
              onTap: () {
                // Navigate to RoomDetailScreen or EditRoomPage to view or edit the room
                Get.to(() => EditRoomPage(room: room));
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Display the room image (you might need to replace it with the actual image URL from Firestore)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/user.jpg', // Replace with room's image URL if applicable
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Display the room rent
                            Text(
                              'Rent: ${room.roomRent}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Display the room type
                            Text(
                              'Room Type: ${room.roomType}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            // Display the address
                            Text(
                              'Location: ${room.address}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            // Display move-in date
                            Text(
                              'Move-In: ${room.moveInDate}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      // Optionally add an icon for favorite/bookmark (if needed)
                      // const Icon(Icons.bookmark_border, color: Colors.grey),
                    ],
                  ),
                ), // You can adjust the color or add any other visual styles
              ),
            );
          },
        );
      }),
    );
  }
}
