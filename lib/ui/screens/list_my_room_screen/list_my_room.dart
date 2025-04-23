import 'dart:typed_data';
import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flatemates_ui/controllers/room.controller.dart';
import 'package:flatemates_ui/res/bottom/bottom_bar.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({super.key});

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController rentController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController securityController = TextEditingController();
  final TextEditingController brokerageController = TextEditingController();
  final TextEditingController setupController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController wifiBillController = TextEditingController();
  final TextEditingController waterBillController = TextEditingController();
  final TextEditingController gasBillController = TextEditingController();
  final TextEditingController maidCostController = TextEditingController();
  final TextEditingController cookCostController = TextEditingController();
  final TextEditingController otherCostsController = TextEditingController();
  final TextEditingController buildingNameController = TextEditingController();
  final TextEditingController localityController = TextEditingController();
  final TextEditingController roomsAvailableController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController maintainanceController = TextEditingController();
  final TextEditingController electricityController = TextEditingController();

  late FocusNode addressFocus;
  late FocusNode rentFocus;
  late FocusNode contactFocus;

  late FocusNode securityFocus;
  late FocusNode brokerageFocus;
  late FocusNode setupFocus;
  late FocusNode descriptionFocus;
  late FocusNode wifiBillFocus;
  late FocusNode waterBillFocus;
  late FocusNode gasBillFocus;
  late FocusNode maidCostFocus;
  late FocusNode cookCostFocus;
  late FocusNode otherCostsFocus;
  late FocusNode roomsAvailableFocus;
  late FocusNode ownerNameFocus;

  final List<Map<String, dynamic>> _amenities = [
    {'title': 'AC', 'iconPath': 'assets/amenities/ac.png'},
    {'title': 'TV', 'iconPath': 'assets/amenities/tv.png'},
    {'title': 'Fridge', 'iconPath': 'assets/amenities/fridge.png'},
    {'title': 'Washing Machine', 'iconPath': 'assets/amenities/washing.png'},
    {'title': 'Water Purifier', 'iconPath': 'assets/amenities/water.png'},
    {'title': 'Geyser', 'iconPath': 'assets/amenities/geyser.png'},
    {'title': 'Sofa', 'iconPath': 'assets/amenities/sofa.png'},
    {'title': 'Dining', 'iconPath': 'assets/amenities/dining.png'},
    {'title': 'Mattress', 'iconPath': 'assets/amenities/mattress.png'},
  ];
  final List<String> _selectedAmenities = [];

  @override
  void initState() {
    super.initState();
    addressFocus = FocusNode();
    rentFocus = FocusNode();
    contactFocus = FocusNode();
    securityFocus = FocusNode();
    brokerageFocus = FocusNode();
    setupFocus = FocusNode();
    descriptionFocus = FocusNode();
    wifiBillFocus = FocusNode();
    waterBillFocus = FocusNode();
    gasBillFocus = FocusNode();
    maidCostFocus = FocusNode();
    cookCostFocus = FocusNode();
    otherCostsFocus = FocusNode();
    roomsAvailableFocus = FocusNode();
    ownerNameFocus = FocusNode();
  }

  @override
  void dispose() {
    addressController.dispose();
    rentController.dispose();
    contactController.dispose();
    securityController.dispose();
    brokerageController.dispose();
    setupController.dispose();
    descriptionController.dispose();

    addressFocus.dispose();
    rentFocus.dispose();
    contactFocus.dispose();

    securityFocus.dispose();
    brokerageFocus.dispose();
    setupFocus.dispose();
    descriptionFocus.dispose();
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
    roomsAvailableController.dispose();
    roomsAvailableFocus.dispose();
    ownerNameController.dispose();
    ownerNameFocus.dispose();
    super.dispose();
  }

  final controller = Get.put(RoomController());
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false; // Flag to track loading state
  List<html.File> selectedFiles = []; // Store selected files as blobs

  Future<void> _pickImages(BuildContext context) async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.multiple = true; // Allow multiple file selection
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files != null) {
        setState(() {
          selectedFiles.addAll(files);
        });
      }
    });
  }

  Future<void> _uploadImages(BuildContext context) async {
    for (var file in selectedFiles) {
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);

      await reader.onLoadEnd.first;
      try {
        final fileName =
            'images/${DateTime.now().millisecondsSinceEpoch}_${file.name}';
        final ref = FirebaseStorage.instance.ref(fileName);
        final uploadTask = ref.putData(reader.result as Uint8List);
        await uploadTask.whenComplete(() async {
          final url = await ref.getDownloadURL();
          controller.imageUrls.add(url);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload image: $e")),
        );
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Images uploaded successfully!")),
    );
  }

  Future<void> _refresh() async {
    setState(() {});
  }

  final List<String> _selectedPreferences = [];
  final List<Map<String, dynamic>> _preferences = [
    {'title': 'Non-Smoker', 'iconPath': 'assets/icons/non_smoker.png'},
    {'title': 'Non-Alcoholic', 'iconPath': 'assets/icons/alcoholic.png'},
    {'title': 'Party Friendly', 'iconPath': 'assets/icons/party.png'},
    {'title': 'Night Owl', 'iconPath': 'assets/icons/night_owl.png'},
  ];

  String _selectedPropertyType = '';
  final List<Map<String, dynamic>> _propertyTypes = [
    {'title': '1 BHK', 'iconPath': 'assets/amenities/home.png'},
    {'title': '2 BHK', 'iconPath': 'assets/amenities/home.png'},
    {'title': '3 BHK', 'iconPath': 'assets/amenities/home.png'},
    {'title': '3+ BHK', 'iconPath': 'assets/amenities/home.png'},
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Go back to Home
        return false; // Prevent default back action (no dialog here)
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      BottomNavBarScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var tween =
                    Tween(begin: const Offset(0.0, 0.0), end: Offset.zero)
                        .chain(CurveTween(curve: Curves.ease));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
          backgroundColor: Color(0xfff8e6f1),
          iconTheme: IconThemeData(color: Color(0xFFB60F6E)),
          title: const Text(
            'Add Your Room Details',
            style: TextStyle(color: Color(0xFFB60F6E)),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth < 600 ? 16.0 : 40.0,
              vertical: 20.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Address Package Section
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
                          'ADDRESS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB60F6E),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          focusNode: addressFocus,
                          nextFocusNode: rentFocus,
                          controller: buildingNameController,
                          label: "Building/Society*",
                          hintText: "Write building or society name",
                          onChanged: (value) {
                            controller.setBuildingName(value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter building/society name';
                            }
                            return null;
                          },
                          isContactNumber: false,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: localityController,
                          focusNode: FocusNode(), // Add missing focusNode
                          label: "Locality*",
                          hintText: "Enter locality",
                          onChanged: (value) {
                            controller.setLocality(value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter locality';
                            }
                            return null;
                          },
                          isContactNumber: false,
                        ),
                        const SizedBox(height: 12),
                        CustomDropdownField(
                          label: "City*",
                          hintText: "Select City",
                          options: const ["Ahmedabad", "Hyderabad", "Bangalore"],
                          onChanged: (value) {
                            controller.setCity(value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a city';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Tenant Preferences Section
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
                          'TENANT PREFERENCES',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB60F6E),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomDropdownField(
                          label: "Preferred Tenant*",
                          hintText: "Select preferred tenant",
                          options: const ["Male", "Female", "Any"],
                          onChanged: (value) {
                            controller.setPreferredTenant(value);
                          },
                        ),
                        const SizedBox(height: 16),
                        Text('Select Preferences', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _preferences.map((pref) {
                            return TenantPreferenceCard(
                              title: pref['title'],
                              iconPath: pref['iconPath'],
                              isSelected: _selectedPreferences.contains(pref['title']),
                              onTap: () {
                                setState(() {
                                  if (_selectedPreferences.contains(pref['title'])) {
                                    _selectedPreferences.remove(pref['title']);
                                  } else {
                                    _selectedPreferences.add(pref['title']);
                                  }
                                  controller.updateTenantPreferences(_selectedPreferences);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Property Details Section
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
                          'PROPERTY DETAILS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB60F6E),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Select Property Type', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _propertyTypes.map((type) {
                            return PropertyTypeCard(
                              title: type['title'],
                              iconPath: type['iconPath'],
                              isSelected: _selectedPropertyType == type['title'],
                              onTap: () {
                                setState(() {
                                  _selectedPropertyType = type['title'];
                                  controller.setHomeType(_selectedPropertyType);
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        CustomDropdownField(
                          label: "Furnish Type*",
                          hintText: "Select Furnish Type",
                          options: const ["Fully Furnished", "Semi Furnished", "Unfurnished"],
                          onChanged: (value) {
                            controller.setFurnishType(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          label: "Number of Rooms Available*",
                          hintText: "Enter number of rooms",
                          controller: roomsAvailableController,
                          focusNode: roomsAvailableFocus,
                          isContactNumber: true,
                          onChanged: (value) {
                            controller.setRoomsAvailable(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomDropdownField(
                          label: "Room Type*",
                          hintText: "Select Room Type",
                          options: const ["Shared", "Private"],
                          onChanged: (value) {
                            controller.setRoomType(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomDropdownField(
                          label: "Washroom Type*",
                          hintText: "Select Washroom Type",
                          options: const ["Attached", "Common"],
                          onChanged: (value) {
                            controller.setWashroomType(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomDropdownField(
                          label: "Parking*",
                          hintText: "Select Parking Type",
                          options: const ["Bike", "Car", "Both"],
                          onChanged: (value) {
                            controller.setParkingType(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomDropdownField(
                          label: "Society Type*",
                          hintText: "Select Society Type",
                          options: const ["Gated", "Standalone", "Individual House", "Villa"],
                          onChanged: (value) {
                            controller.setSocietyType(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomDatePickerField(
                          label: "Move-in Date*",
                          onChanged: (value) {
                            controller.setMoveInDate(value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a move-in date';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Amenities Section
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
                          'AMENITIES',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB60F6E),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Select Available Amenities', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _amenities.map((amenity) {
                            return PropertyTypeCard(
                              title: amenity['title'],
                              iconPath: amenity['iconPath'],
                              isSelected: _selectedAmenities.contains(amenity['title']),
                              onTap: () {
                                setState(() {
                                  if (_selectedAmenities.contains(amenity['title'])) {
                                    _selectedAmenities.remove(amenity['title']);
                                  } else {
                                    _selectedAmenities.add(amenity['title']);
                                  }
                                  controller.updateAmenities(_selectedAmenities);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Rent and Charges Section
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
                          'RENT AND CHARGES',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB60F6E),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          focusNode: rentFocus,
                          controller: rentController,
                          label: "Room Rent*",
                          hintText: "e.g. \₹5000",
                          onChanged: (value) {
                            controller.setRoomRent(value);
                          },
                          isContactNumber: true,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: maintainanceController,
                          focusNode: FocusNode(),
                          label: "Maintenance",
                          hintText: "Enter maintenance cost",
                          onChanged: (value) {
                            // Add maintenance setter
                          },
                          isContactNumber: true,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          focusNode: securityFocus,
                          controller: securityController,
                          label: "Security Deposit",
                          hintText: "Enter security deposit",
                          onChanged: (value) {
                            controller.setSecurityDeposit(value);
                          },
                          isContactNumber: true,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          controller: electricityController,
                          focusNode: FocusNode(),
                          label: "Electricity",
                          hintText: "Enter electricity charges",
                          onChanged: (value) {
                            // Add electricity setter
                          },
                          isContactNumber: true,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          focusNode: setupFocus,
                          controller: setupController,
                          label: "Setup Cost",
                          hintText: "Enter setup cost",
                          onChanged: (value) {
                            controller.setSetupCost(value);
                          },
                          isContactNumber: true,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          focusNode: brokerageFocus,
                          controller: brokerageController,
                          label: "Brokerage",
                          hintText: "Enter brokerage",
                          onChanged: (value) {
                            controller.setBrokerage(value);
                          },
                          isContactNumber: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Additional Costs Section
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
                          'ADDITIONAL COSTS',
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
                          onChanged: (value) {
                            controller.setWifiBill(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          label: "Water Bill",
                          hintText: "Enter water bill amount",
                          controller: waterBillController,
                          focusNode: waterBillFocus,
                          isContactNumber: true,
                          onChanged: (value) {
                            controller.setWaterBill(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          label: "Gas Bill",
                          hintText: "Enter gas bill amount",
                          controller: gasBillController,
                          focusNode: gasBillFocus,
                          isContactNumber: true,
                          onChanged: (value) {
                            controller.setGasBill(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          label: "Maid Cost",
                          hintText: "Enter maid service cost",
                          controller: maidCostController,
                          focusNode: maidCostFocus,
                          isContactNumber: true,
                          onChanged: (value) {
                            controller.setMaidCost(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          label: "Cook Cost",
                          hintText: "Enter cook service cost",
                          controller: cookCostController,
                          focusNode: cookCostFocus,
                          isContactNumber: true,
                          onChanged: (value) {
                            controller.setCookCost(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          label: "Other Costs",
                          hintText: "Enter any other costs",
                          controller: otherCostsController,
                          focusNode: otherCostsFocus,
                          isContactNumber: true,
                          onChanged: (value) {
                            controller.setOtherCosts(value);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Description Section
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
                          'DESCRIPTION',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB60F6E),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          focusNode: descriptionFocus,
                          controller: descriptionController,
                          label: "Description",
                          hintText: "Enter a detailed description of your property",
                          onChanged: (value) {
                            controller.setDescription(value);
                          },
                          isContactNumber: false,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Images Upload Section
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
                          'UPLOAD IMAGES',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB60F6E),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8.0,
                          children: selectedFiles.map((file) {
                            final reader = html.FileReader();
                            reader.readAsDataUrl(file);
                            return FutureBuilder(
                              future: reader.onLoadEnd.first,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  return Image.network(
                                    reader.result as String,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  );
                                }
                                return CircularProgressIndicator();
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => _pickImages(context),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Color(0xFFB60F6E),
                          ),
                          child: Text(
                            'Select Images',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Contact Info Section
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
                          'CONTACT INFORMATION',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB60F6E),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: "Owner Name*",
                          hintText: "Enter owner name",
                          controller: ownerNameController,
                          focusNode: ownerNameFocus,
                          isContactNumber: false,
                          onChanged: (value) {
                            controller.setOwnerName(value);
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          focusNode: contactFocus,
                          controller: contactController,
                          label: "Contact Number*",
                          hintText: "Enter Contact number",
                          onChanged: (value) {
                            if (value.isNotEmpty && !RegExp(r'^[9876]\d*$').hasMatch(value)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Contact number must start with 9, 8, 7, or 6"),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                            controller.setMobileNumber(value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a contact number';
                            }
                            if (!RegExp(r'^[9876]\d*$').hasMatch(value)) {
                              return 'Contact number must start with 9, 8, 7, or 6';
                            }
                            return null;
                          },
                          isContactNumber: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  // Submit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await _uploadImages(context);
                          await controller.submitRoomListing();
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  RoomList(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                var tween = Tween(
                                    begin: const Offset(0.0, 0.0),
                                    end: Offset.zero)
                                    .chain(CurveTween(curve: Curves.ease));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
                        backgroundColor: Color(0xFFB60F6E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final ValueChanged<String> onChanged;
  final String? initialValue; // Add initialValue for autofill functionality
  final String? Function(String?)? validator;
  final bool isContactNumber;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.initialValue, // Accept initial value for autofill
    this.validator,
    this.isContactNumber = false,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          initialValue: widget.initialValue, // Pass initial value to autofill
          onChanged: widget.onChanged,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFB60F6E)),
            ),
          ),
          textInputAction: widget.nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,
          keyboardType:
          widget.isContactNumber ? TextInputType.phone : TextInputType.text,
          inputFormatters: widget.isContactNumber
              ? [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10)
          ]
              : null,
          onFieldSubmitted: (value) {
            if (widget.nextFocusNode != null) {
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            }
          },
        ),
      ],
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final String? selectedValue; // Added for pre-select functionality
  final String? Function(String?)? validator;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.options,
    required this.onChanged,
    this.selectedValue, // Accept selected value for autofill
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: options.contains(selectedValue) ? selectedValue : null,
          dropdownColor: Colors.white,
          hint: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              hintText,
              style: const TextStyle(),
              overflow: TextOverflow.visible,
            ),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFFB60F6E),
              ),
            ),
          ),
          items: options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          validator: validator,
        ),
      ],
    );
  }
}


class CustomDatePickerField extends StatefulWidget {
  final String label;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const CustomDatePickerField({
    required this.label,
    required this.onChanged,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  _CustomDatePickerFieldState createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  String? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primaryColor: Colors.purple, // Primary color (affects header)
            hintColor: Colors.green, // Affects selected text color
            colorScheme: ColorScheme.light(
              primary: Colors.purple, // Header background & selected date
              onPrimary: Colors.white, // Text color on header
              onSurface: Colors.black, // Text color on calendar
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = "${pickedDate.toLocal()}".split(' ')[0]; // Format: YYYY-MM-DD
      });
      widget.onChanged(selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFB60F6E)),
        ),
        labelText: widget.label,
        hintText: "Select Move-in Date",
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ),
      controller: TextEditingController(text: selectedDate),
      onTap: () => _selectDate(context),
      validator: widget.validator,
    );
  }
}

class TenantPreferenceCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const TenantPreferenceCard({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 8, bottom: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFB60F6E).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xFFB60F6E) : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              width: 24,
              height: 24,
              color: isSelected ? Color(0xFFB60F6E) : Colors.grey[600],
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Color(0xFFB60F6E) : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyTypeCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const PropertyTypeCard({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(right: 8, bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFB60F6E).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFFB60F6E) : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              width: 40,
              height: 40,
              color: isSelected ? Color(0xFFB60F6E) : Colors.grey[600],
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Color(0xFFB60F6E) : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
