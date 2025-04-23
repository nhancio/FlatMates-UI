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
  final TextEditingController wifiBillController = TextEditingController();
  final TextEditingController waterBillController = TextEditingController();
  final TextEditingController gasBillController = TextEditingController();
  final TextEditingController maidCostController = TextEditingController();
  final TextEditingController cookCostController = TextEditingController();
  final TextEditingController otherCostsController = TextEditingController();
  
  late FocusNode addressFocus;
  late FocusNode rentFocus;
  late FocusNode contactFocus;
  late FocusNode wifiBillFocus;
  late FocusNode waterBillFocus;
  late FocusNode gasBillFocus;
  late FocusNode maidCostFocus;
  late FocusNode cookCostFocus;
  late FocusNode otherCostsFocus;

  @override
  void dispose() {
    addressController.dispose();
    rentController.dispose();
    contactController.dispose();
    addressFocus.dispose();
    rentFocus.dispose();
    contactFocus.dispose();
    wifiBillController.dispose();
    waterBillController.dispose();
    gasBillController.dispose();
    maidCostController.dispose();
    cookCostController.dispose();
    otherCostsController.dispose();
    wifiBillFocus.dispose();
    waterBillFocus.dispose();
    gasBillFocus.dispose();
    maidCostFocus.dispose();
    cookCostFocus.dispose();
    otherCostsFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    addressFocus = FocusNode();
    rentFocus = FocusNode();
    contactFocus = FocusNode();
    wifiBillFocus = FocusNode();
    waterBillFocus = FocusNode();
    gasBillFocus = FocusNode();
    maidCostFocus = FocusNode();
    cookCostFocus = FocusNode();
    otherCostsFocus = FocusNode();
    // Autofill fields with room data when editing
    if (widget.room != null) {
      controller.setRoomType(widget.room!.roomType);
      controller.setHomeType(widget.room!.homeType);
      controller.setBuildingName(widget.room!.buildingName);
      controller.setRoomRent(widget.room!.roomRent);
      controller.setMoveInDate(widget.room!.moveInDate);
      controller.setOccupationPerRoom(widget.room!.occupationPerRoom);
      wifiBillController.text = widget.room!.wifiBill;
      waterBillController.text = widget.room!.waterBill;
      gasBillController.text = widget.room!.gasBill;
      maidCostController.text = widget.room!.maidCost;
      cookCostController.text = widget.room!.cookCost;
      otherCostsController.text = widget.room!.otherCosts;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Go back to Home
        return false; // Prevent default back action (no dialog here)
      },
      child: Scaffold(
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
              // Building Name TextField
              CustomTextField(
                label: "Building/Society*",
                hintText: "Write building or society name",
                onChanged: (value) {
                  controller.setBuildingName(value);
                },
                isContactNumber: false, 
                controller: addressController, 
                focusNode: addressFocus,
              ),
              const SizedBox(height: 12),
              // Room Rent TextField
              CustomTextField(
                label: "Room Rent*",
                hintText: "e.g. \$5000",
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
              const SizedBox(height: 24),
              // Additional Bills Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ADDITIONAL BILLS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB60F6E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: "WiFi Bill",
                      hintText: "Enter WiFi bill amount",
                      controller: wifiBillController,
                      focusNode: wifiBillFocus,
                      isContactNumber: true,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: "Water Bill",
                      hintText: "Enter water bill amount",
                      controller: waterBillController,
                      focusNode: waterBillFocus,
                      isContactNumber: true,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: "Gas Bill",
                      hintText: "Enter gas bill amount",
                      controller: gasBillController,
                      focusNode: gasBillFocus,
                      isContactNumber: true,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              // Service Costs Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SERVICE COSTS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB60F6E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: "Maid Cost",
                      hintText: "Enter maid service cost",
                      controller: maidCostController,
                      focusNode: maidCostFocus,
                      isContactNumber: true,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: "Cook Cost",
                      hintText: "Enter cook service cost",
                      controller: cookCostController,
                      focusNode: cookCostFocus,
                      isContactNumber: true,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      label: "Other Costs",
                      hintText: "Enter any other costs",
                      controller: otherCostsController,
                      focusNode: otherCostsFocus,
                      isContactNumber: true,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final updatedRoom = Room(
                      id: widget.room?.id ?? UniqueKey().toString(),
                      buildingName: controller.buildingName.value,
                      locality: controller.locality.value,
                      city: controller.city.value,
                      homeType: controller.homeType.value,
                      furnishType: controller.furnishType.value,
                      roomsAvailable: controller.roomsAvailable.value,
                      roomType: controller.roomType.value,
                      washroomType: controller.washroomType.value,
                      parkingType: controller.parkingType.value,
                      societyType: controller.societyType.value,
                      moveInDate: controller.moveInDate.value,
                      occupationPerRoom: controller.occupationPerRoom.value,
                      roomRent: controller.roomRent.value,
                      userId: widget.room?.userId ?? "",
                      selectedValues: controller.selectedValues,
                      amenities: controller.amenities,
                      preferredTenant: controller.preferredTenant.value,
                      tenantPreferences: controller.tenantPreferences,
                      ownerName: controller.ownerName.value,
                      mobileNumber: controller.mobileNumber.value,
                      wifiBill: wifiBillController.text,
                      waterBill: waterBillController.text,
                      gasBill: gasBillController.text,
                      maidCost: maidCostController.text,
                      cookCost: cookCostController.text,
                      otherCosts: otherCostsController.text,
                    );
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
      ),
    );
  }
}
