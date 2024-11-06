/*
import 'package:flatmates/Jay/res/assets/icons/icons.dart';
import 'package:flatmates/Jay/ui/screens/ai_screen/ai_screen.dart';
import 'package:flatmates/Jay/ui/screens/chat_screen/chat_screen.dart';
import 'package:flatmates/Jay/ui/screens/home_screen/home_screen.dart';
import 'package:flatmates/Jay/ui/screens/profile_screen/profile_screen.dart';
import 'package:flatmates/Jay/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
  HomePage(),
    ChatListScreen(),

    HomemateRoomScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.home_outlined, 'Home', 0),
              _buildBottomNavItem(Icons.wechat_sharp, 'Chat', 1),
              SizedBox(width: 48), // Space for the FAB
              _buildBottomNavItem(Icons.book_outlined, 'Booking', 2),
              _buildBottomNavItem(Icons.person_outline, 'Profile', 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=> VoiceInputScreen()));
        },
        child:Image.asset(AppIcons.ai,height: 20,width: 20,),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:flatemates_ui/Jay/res/assets/icons/icons.dart';
import 'package:flatemates_ui/Jay/ui/screens/ai_screen/ai_screen.dart';
import 'package:flatemates_ui/Jay/ui/screens/chat_screen/chat_screen.dart';
import 'package:flatemates_ui/Jay/ui/screens/home_screen/home_screen.dart';
import 'package:flatemates_ui/Jay/ui/screens/profile_screen/profile_screen.dart';
import 'package:flatemates_ui/Jay/ui/screens/saved_screen/saved_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ChatListScreen(),
    HomemateRoomScreen(),
    ProfileScreen(),
    VoiceInputScreen(),  // Adding VoiceInputScreen to the list of pages
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the current page based on index
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.home_outlined, 'Home', 0),
              _buildBottomNavItem(Icons.wechat_sharp, 'Chat', 1),
              SizedBox(width: 48), // Space for the FAB
              _buildBottomNavItem(Icons.book_outlined, 'Booking', 2),
              _buildBottomNavItem(Icons.person_outline, 'Profile', 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Update index to navigate to VoiceInputScreen
          setState(() {
            _currentIndex = 4;  // Index for VoiceInputScreen
          });
        },
        child: Image.asset(AppIcons.ai, height: 20, width: 20),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index; // Change the current page index
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
