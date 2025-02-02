import 'package:flatemates_ui/controllers/room.controller.dart';
import 'package:flatemates_ui/models/room.model.dart';
import 'package:flatemates_ui/ui/screens/list_my_room_screen/list_my_room.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditRoomPage extends StatefulWidget {
  final Room? room; // Room data passed to this page for editing

  const EditRoomPage({super.key, this.room});

  @override
  _EditRoomPageState createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  final RoomController controller = Get.find<RoomController>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  late FocusNode addressFocus;
  late FocusNode rentFocus;
  late FocusNode contactFocus;




  @override
  void dispose() {
    addressController.dispose();
    rentController.dispose();
    contactController.dispose();
    addressFocus.dispose();
    rentFocus.dispose();
    contactFocus.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    addressFocus = FocusNode();
    rentFocus = FocusNode();
    contactFocus = FocusNode();
    // Autofill fields with room data when editing
    if (widget.room != null) {
      controller.setRoomType(widget.room!.roomType);
      controller.setHomeType(widget.room!.homeType);
      controller.setAddress(widget.room!.address);
      controller.setRoomRent(widget.room!.roomRent);
      controller.setMoveInDate(widget.room!.moveInDate);
      controller.setOccupationPerRoom(widget.room!.occupationPerRoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room == null ? 'Add Room' : 'Edit Room'),
      ),
      body: SingleChildScrollView(

        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 600 ? 16.0 : 40.0,
          vertical: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            // Room Type Dropdown
            CustomDropdownField(
              label: "Room Type*",
              hintText: "Select Room Type",
              options: const ["1BHK", "2BHK", "3BHK"],
              selectedValue: controller.roomType.value, // Autofill value
              onChanged: (value) {
                controller.setRoomType(value);
              },
            ),
            const SizedBox(height: 12),
            CustomDropdownField(
              label: "Home Type*",
              hintText: "Select Home Type",
              options: const [
                "Apartment",
                "Individual House",
                "Gated Community Flat",
                "Villa"
              ],
              selectedValue: controller.homeType.value, // Autofill value
              onChanged: (value) {
                controller.setHomeType(value);
              },
            ),
            const SizedBox(height: 12),
            // Address TextField
            CustomTextField(
              label: "Address*",
              hintText: "Write your address...",
              initialValue: controller.address.value, // Autofill value
              onChanged: (value) {
                controller.setAddress(value);
              },
              isContactNumber: false, controller: addressController, focusNode: addressFocus,
            ),
            const SizedBox(height: 12),
            // Room Rent TextField
            CustomTextField(
              label: "Room Rent*",
              hintText: "e.g. \$5000",
              initialValue: controller.roomRent.value, // Autofill value
              onChanged: (value) {
                controller.setRoomRent(value);
              },
              isContactNumber: true, controller: rentController, focusNode: rentFocus,
            ),
            const SizedBox(height: 12),
            // Move In Date Dropdown
            CustomDropdownField(
              label: "Move in Date",
              hintText: "Select an option",
              options: const ["Immediately", "1 Month", "3 Months"],
              selectedValue: controller.moveInDate.value, // Autofill value
              onChanged: (value) {
                controller.setMoveInDate(value);
              },
            ),
            const SizedBox(height: 12),
            // Occupation per room Dropdown
            CustomDropdownField(
              label: "Occupation per room",
              hintText: "Select an option",
              options: const ["1 Person", "2 Persons", "3 Persons"],
              selectedValue:
                  controller.occupationPerRoom.value, // Autofill value
              onChanged: (value) {
                controller.setOccupationPerRoom(value);
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final updatedRoom = Room(
                      id: widget.room?.id ??
                          UniqueKey()
                              .toString(), // If editing, keep the same ID
                      roomType: controller.roomType.value,
                      homeType: controller.homeType.value,
                      address: controller.address.value,
                      roomRent: controller.roomRent.value,
                      moveInDate: controller.moveInDate.value,
                      occupationPerRoom: controller.occupationPerRoom.value,
                      userId: widget.room?.userId ?? "", selectedValues: controller.selectedValues);
                  controller.updateRoom(updatedRoom); // Pass the updated room
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  backgroundColor: Color(0xFFB60F6E), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
