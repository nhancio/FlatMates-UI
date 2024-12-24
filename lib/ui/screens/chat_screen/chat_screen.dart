import 'package:flutter/material.dart';

import '../../../res/bottom/bottom_bar.dart';

class ChatListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Daniel',
      'message': 'What kind of music do you like and what app do you use?',
      'time': '7:11 PM',
      'unreadCount': 10,
      'profilePic': 'assets/icons/danile.png',
    },
    {
      'name': 'Laura Levy',
      'message': "How's your night going?",
      'time': '7:02 PM',
      'unreadCount': 5,
      'profilePic': 'assets/icons/laura.png',
    },
    {
      'name': 'Timothy Steele',
      'message': 'Yes sure, but this is not something I like though',
      'time': '6:50 PM',
      'unreadCount': 2,
      'profilePic': 'assets/icons/mike.png',
    },
    {
      'name': 'Lou Quinn',
      'message': 'Congrats! after all these searches you finally made it!',
      'time': '6:11 PM',
      'unreadCount': 8,
      'profilePic': 'assets/icons/tome.png',
    },
    {
      'name': 'Josephine Gordon',
      'message': "I'm so tired of this day, too much work to do!",
      'time': '6:01 PM',
      'unreadCount': 10,
      'profilePic': 'assets/icons/danile.png',
    },
    {
      'name': 'Mike',
      'message': 'Mike, are you available',
      'time': '5:30 PM',
      'unreadCount': 7,
      'profilePic': 'assets/icons/mike.png',
    },
    {
      'name': 'Jessie',
      'message': 'Do not forget to take the dog out on Thursday night',
      'time': '7:11 PM',
      'unreadCount': 10,
      'profilePic': 'assets/icons/laura.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        iconTheme: IconThemeData(
          color:Color(0xFFB60F6E),
        ),
        title: Text(
          'Message',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color:Color(0xFFB60F6E),
          ),
        ),
        backgroundColor: Color(0xfff8e6f1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFB60F6E)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
                  (route) => false,
            );
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle chat item tap (e.g., navigate to chat details)
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.symmetric(vertical: 8),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(chats[index]['profilePic']),
                      radius: 30,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chats[index]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            chats[index]['message'],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chats[index]['time'],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        if (chats[index]['unreadCount'] > 0)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              chats[index]['unreadCount'].toString(),
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
