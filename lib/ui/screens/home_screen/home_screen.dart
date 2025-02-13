import 'dart:async';
import 'dart:html' as html;
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatemates_ui/controllers/bottomnav.controller.dart';
import 'package:flatemates_ui/controllers/tab.controller.dart';
import 'package:flatemates_ui/ui/a.dart';
import 'package:flatemates_ui/ui/b.dart';
import 'package:flatemates_ui/ui/screens/list_my_room_screen/list_my_room.dart';
import 'package:flatemates_ui/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/room.controller.dart';


class HomePage extends StatefulWidget {
  final String userId;

  HomePage({required this.userId});


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BottomNavController bottomNavController = Get.put(BottomNavController());
  TabControllerState tabCtrl = Get.put(TabControllerState());
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final controller = Get.put(RoomController());
  void createNewRoom() {
    controller.imageUrls.clear(); // Clear previous images
    controller.selectedValues.clear();
    // Continue with new room creation logic
  }

  String? selectedCity;
  final List<String> cities = [
    'Hyderabad',
    'Bangalore',
    'Ahmedabad',
    'Delhi',
  ];
  List<String> filteredCities = [];
  bool showDropdown = false; // Controls visibility of dropdown list
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCities = cities; // Initialize filtered list with all cities

  }

  void filterCities(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCities = cities;
      } else {
        filteredCities = cities
            .where((city) => city.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<Map<String, String>> fetchUserDetails(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        String userName = userDoc['userName'] ?? 'N/A';

        return {
          'userName': userName,
        };
      } else {
        return {
          'userName': 'User not found',
        };
      }
    } catch (e) {
      return {
        'userName': 'Error',
      };
    }
  }

  Future<void> _refresh() async {
    setState(() {}); 
  }


/*  Future<bool> _onWillPop(BuildContext context) async {
    bool? closeApp = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Do you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {

                Navigator.of(context).pop(true);
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {

                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    // If closeApp is true, allow the app to close
    return closeApp ?? false; // Default to false if null
  }*/

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'User not logged in. Please log in first.',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Go back to Home
        return false; // Prevent default back action (no dialog here)
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isWideScreen = constraints.maxWidth > 600;
              return Stack(
                children: [
                  // Background Image
                  /*  Positioned(
                    child: Image.asset(
                      Images.firstScreen,
                      fit: BoxFit.cover,
                      height:
                          MediaQuery.of(context).size.height, // Full screen height
                      width: MediaQuery.of(context).size.width, // Full screen width
                    ),
                  ),
                  // Foreground Content with Gradient Overlay for better readability
                  Positioned.fill(
                    child: Container(
                      color: AppColors.backgroundOpacity.withOpacity(1),
                    ),
                  ),*/
                  // Main Content

                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWideScreen ? 100.0 : 20.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          FutureBuilder<Map<String, String>>(
                            future: fetchUserDetails(userId!), // Pass userId here
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Row(
                                  children: const [
                                    // CircularProgressIndicator(),
                                    SizedBox(width: 10),
                                    Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return const Text(
                                  'Error fetching data!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                final userDetails = snapshot.data!;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Hi ${userDetails['userName']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFB60F6E),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const Text(
                                  'User not found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                );
                              }
                            },
                          ),
                          const Text(
                            "Let's Find Peace For You!",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Search Bar with city dropdown
                        /*  TextButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressMapWeb(address: "New York, USA"),
                              ),
                            );
                          }, child: Text("Hello")),*/
                          Container(
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                          
                              border: Border.all(
                                  color: Colors.grey
                                      .withOpacity(0.5)), // Adding border
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Search Bar
                                    TextField(
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        hintText: "Search City",
                                        prefixIcon: Icon(Icons.search),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                      onChanged: (query) {
                                        setState(() {
                                          filteredCities = cities
                                              .where((city) =>
                                              city.toLowerCase().contains(query.toLowerCase()))
                                              .toList();
                                          showDropdown = query.isNotEmpty;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    // Dropdown Items
                                    if (showDropdown)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.grey[300]!),
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: SizedBox(
                                          height: 90,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: AlwaysScrollableScrollPhysics(), // Ensures scrolling
                                            // Ensures dropdown doesn't overflow
                                            itemCount: filteredCities.length,
                                            itemBuilder: (context, index) {
                                              final city = filteredCities[index];
                                              return ListTile(
                                                title: Text(city),
                                                onTap: () {
                                                  setState(() {
                                                    selectedCity =
                                                        city; // Update selected city
                                                    searchController.text =
                                                        city; // Show in search bar
                                                    showDropdown =
                                                        false; // Hide dropdown
                                                  });

                                                              if (city == "Ahmedabad") {
                                                    Get.to(() => RoomList(), arguments: {'city': city});}
                                                         },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              // Row with two boxes
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // First box with image size
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) =>
                                              HomemateList(userId: '',),
                                          transitionsBuilder:
                                              (context, animation, secondaryAnimation, child) {
                                            var tween = Tween(
                                                begin: const Offset(0.0, 0.0), end: Offset.zero)
                                                .chain(CurveTween(curve: Curves.ease));
                                            var offsetAnimation = animation.drive(tween);
                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                   /*   Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Scaffold(
                                              body: HomemateList(userId: '',),

                                            )),
                                      );*/
                                      // tabCtrl.tabController.index = 0;
                                      // bottomNavController.setIndex(
                                      //     2); // For example, to navigate to the 'Saved' screen

                                      // _showBottomSheet(context, 'HomemateList');
                                    },
                                    child: _buildServiceCard(
                                      'assets/images/look_roommate.png',
                                      160.0, // Width of the box
                                      160.0, // Height of the image
                                    ),
                                  ),
                                  // Second box with image size
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) =>
                                          RoomList(),
                                          transitionsBuilder:
                                              (context, animation, secondaryAnimation, child) {
                                            var tween = Tween(
                                                begin: const Offset(0.0, 0.0), end: Offset.zero)
                                                .chain(CurveTween(curve: Curves.ease));
                                            var offsetAnimation = animation.drive(tween);
                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                 /*     Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Scaffold(
                                              body: RoomList(),

                                            )),
                                      );*/
                                      // bottomNavController.setIndex(2);
                                      // tabCtrl.tabController.index = 1;
                                      // _showBottomSheet(context, 'RoomList');
                                    },
                                    child: _buildServiceCard(
                                      'assets/images/look_room.png',
                                      160.0, // Width of the box
                                      160.0, // Height of the image
                                    ),
                                  ),
                                ],
                              ),
                              // Third box with image size (in a separate column to avoid overflow)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      createNewRoom();
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) =>

                                              AddRoomPage(),
                                          transitionsBuilder:
                                              (context, animation, secondaryAnimation, child) {
                                            var tween = Tween(
                                                begin: const Offset(0.0, 0.0), end: Offset.zero)
                                                .chain(CurveTween(curve: Curves.ease));
                                            var offsetAnimation = animation.drive(tween);
                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );

                                   /*Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const AddRoomPage(),
                                        ),
                                      );*/
                                    },
                                    child: _buildServiceCard(
                                      'assets/images/list_room.png',
                                      160.0, // Width of the box
                                      160.0, // Height of the image
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {


                                      /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddRoomPage(),
                                    ),
                                  );*/
                                    },
                                    child:Padding(
                                      padding:  EdgeInsets.only(top: 20.0,right: 10),
                                      child: Container(

                                      height:   140.0,
                                      width:   140.0,
                                        child: Card(
                                          color: Color(0xffF8E7F1),
                                          elevation: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 1.0,top: 1),
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center, // Center the text
                                              children: [
                                                Text(
                                                  "Upcoming Features",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(height: 6), // Space between texts
                                                Text(
                                                  "AI Match Making",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54,
                                                  ),
                                                  textAlign: TextAlign.center, // Center-align text
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String listType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // Allows flexible height
      backgroundColor: Colors.transparent,
      // To make the background transparent
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0), // Adjust left curve
          topRight: Radius.circular(30.0), // Adjust right curve
        ),
      ),
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
                30.0), // Match the same radius for the container
            topRight: Radius.circular(
                30.0), // Match the same radius for the container
          ),
          child: Container(
            height: 700, // Increased height
            color: Colors.white, // Background color of the bottom sheet
            child: Column(
              children: [
                // Show content based on listType
                Expanded(
                  child: listType == 'HomemateList'
                      ? HomemateList(
                          userId: '',
                        ) // Show HomemateRoomScreen content
                      : RoomList(), // Show RoomListingPage content
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildServiceCard(
      String imagePath, double boxWidth, double imageHeight) {
    return Container(
      width: boxWidth, // Width of the box
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: imageHeight, // Height of the image, dynamic size
            fit: BoxFit.contain,
          ),
          // Optionally, you can add a title or other content here
        ],
      ),
    );
  }
}




class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  final List<String> infoBoxes = [
    "Incubated by T-HUB  \nFounded by IITIANS",
    //"User Info:\n- Name: John Doe\n- Gender: Male\n- Profession: Engineer \n- Call and Saved/Unsaved",
   // "Upcoming Features:\n- AI Recommendations\n- HubSpot Integration",
  ];

  final ScrollController _scrollController = ScrollController();
  late Timer _scrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _scrollTimer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(Duration(milliseconds: 100), (_) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final currentPosition = _scrollController.offset;

        if (currentPosition >= maxScrollExtent) {
          _scrollController.jumpTo(0); // Reset to the beginning
        } else {
          _scrollController.animateTo(
            currentPosition + 2, // Scroll a small amount
            duration: Duration(milliseconds: 30),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
       // controller: _scrollController,
        child: Row(
          children: infoBoxes
              .map((text) => _buildInfoBox(text))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 48.0),
      child: Center(
        child: Container(
          height: 140,
          width: 240,

          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 8.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}


