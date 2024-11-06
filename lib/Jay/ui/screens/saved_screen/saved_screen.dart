import 'package:flatemates_ui/Jay/ui/screens/homemate_details_screen/homemate_details.dart';
import 'package:flatemates_ui/Jay/ui/screens/room_details_screen/room_details.dart';
import 'package:flutter/material.dart';

class HomemateRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Homemate & Room",
            style: TextStyle(color: Colors.purple),
          ),
          bottom: TabBar(
            indicatorColor: Colors.purple,
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Homemate'),
              Tab(text: 'Room'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomemateList(),
            RoomList(),
          ],
        ),
      ),
    );
  }
}

class HomemateList extends StatelessWidget {
  final List<Map<String, String>> homemates = [
    {
      'name': 'Daniel',
      'age': '26',
      'profession': 'Artist',
      'location': 'Gachibowli, Hyderabad',
      'profilePic': 'assets/images/john.png',
    },
    {
      'name': 'Sara',
      'age': '24',
      'profession': 'Athlete',
      'location': 'Madhapur, Hyderabad',
      'profilePic': 'assets/images/sara.png',
    },
    {
      'name': 'Mike',
      'age': '27',
      'profession': 'Traveler',
      'location': 'Jubilee Hills, Hyderabad',
      'profilePic': 'assets/images/sohan.png',
    },
    {
      'name': 'Andera',
      'age': '26',
      'profession': 'Dancer',
      'location': 'Gachibowli, Hyderabad',
      'profilePic': 'assets/images/andera.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: homemates.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeMateDetailsScreen(),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      homemates[index]['profilePic']!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${homemates[index]['name']}',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 4),
                        Text('Age: ${homemates[index]['age']}', style: TextStyle(color: Colors.white)),
                        Text('Profession: ${homemates[index]['profession']}', style: TextStyle(color: Colors.white)),
                        Text('Location: ${homemates[index]['location']}', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Icon(Icons.bookmark_border, color: Colors.white),
                ],
              ),
            ),
            color: Colors.purple,
          ),
        );
      },
    );
  }
}

class RoomList extends StatelessWidget {
  final List<Map<String, String>> rooms = [
    {
      'rent': '2600/-',
      'furnished': 'Fully',
      'location': 'Gachibowli, Hyderabad',
      'roomPic': 'assets/images/bad1.png',
    },
    {
      'rent': '2600/-',
      'furnished': 'Fully',
      'location': 'Gachibowli, Hyderabad',
      'roomPic': 'assets/images/bad2.png',
    },
    {
      'rent': '2600/-',
      'furnished': 'Fully',
      'location': 'Gachibowli, Hyderabad',
      'roomPic': 'assets/images/bad3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RoomDetailScreen(),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      rooms[index]['roomPic']!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rent: ${rooms[index]['rent']}',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 4),
                        Text('Furnished: ${rooms[index]['furnished']}', style: TextStyle(color: Colors.white)),
                        Text('Location: ${rooms[index]['location']}', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Icon(Icons.bookmark_border, color: Colors.white),
                ],
              ),
            ),
            color: Colors.purple,
          ),
        );
      },
    );
  }
}
