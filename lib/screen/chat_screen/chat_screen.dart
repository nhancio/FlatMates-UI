import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String chatName;

  ChatScreen({required this.chatName});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/daniel.png'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chatName, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
                Text(
                  'Last seen: 2:02 PM',
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: isDarkMode ? Colors.white : Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              children: [
                buildReceivedMessage(context, 'Hey There!', '8:30 PM'),
                buildReceivedMessage(context, 'How are you?', '8:30 PM'),
                buildReceivedMessage(context, 'How was your day?', '8:30 PM'),
                buildSentMessage(context, 'Hello!', '8:33 PM'),
                buildSentMessage(context, 'I am fine and how are you?', '8:34 PM'),
                buildSentMessage(context, 'Today was great!!!', '8:34 PM'),
                buildReceivedMessage(context, 'I am doing well, Can we meet tomorrow?', '8:36 PM'),
                buildSentMessage(context, 'Yes Sure!', '8:58 PM'),
                buildSentMessage(context, 'At what time?', '8:59 PM'),
              ],
            ),
          ),
          buildMessageInputField(context),
        ],
      ),
    );
  }

  Widget buildReceivedMessage(BuildContext context, String message, String time) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            SizedBox(height: 5),
            Text(time, style: TextStyle(fontSize: 10, color: isDarkMode ? Colors.grey[400] : Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget buildSentMessage(BuildContext context, String message, String time) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.purpleAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(message, style: TextStyle(color: Colors.white)),
            SizedBox(height: 5),
            Text(time, style: TextStyle(fontSize: 10, color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget buildMessageInputField(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.purpleAccent),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type your message here...',
                hintStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt, color: Colors.purpleAccent),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.purpleAccent),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
