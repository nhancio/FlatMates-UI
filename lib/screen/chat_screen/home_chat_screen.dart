import 'package:flatmates/screen/chat_screen/chat_screen.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // If you're using GetX for navigation

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> with SingleTickerProviderStateMixin{
    late TabController _tabController;
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
          },
        ),
        title: Text('Your Messages', style: AppTextStyles.titleStyle(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Flatmate'),
            Tab(text: 'Room'),
          ],
          indicatorColor: Colors.purple,
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              buildMessageTile(context, 'Daniel', 'What kind of music do you like and what app do you use?', '7:11 PM', 'assets/images/daniel.png', true),
              buildMessageTile(context, 'Laura Levy', 'Hi Tina. How\'s your night going?', '7:11 PM', 'assets/images/daniel.png', true),
              buildMessageTile(context, 'Ellen Lambert', 'Cool! let\'s meet at 16:00 near the shopping mall', '7:11 PM', 'assets/images/daniel.png', false),
              buildMessageTile(context, 'Timothy Steele', 'Yeas sure, but this is not something I like though', '7:11 PM', 'assets/images/daniel.png', false),
              buildMessageTile(context, 'Lou Quinn', 'Congrats! after all this searches you finally made it!', '7:11 PM', 'assets/images/daniel.png', false),
              buildMessageTile(context, 'Josephine Gordon', 'I\'m so tired of this day too much work to do!', '7:11 PM', 'assets/images/daniel.png', false),
              buildMessageTile(context, 'Mike', 'Do not forget to take the dog out on Thursday night', '7:11 PM', 'assets/images/daniel.png', false),
              buildMessageTile(context, 'Jessie', 'Do not forget to take the dog out on Thursday night', '7:11 PM', 'assets/images/daniel.png', false),
            ],
          ),
           ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              buildMessageTile(context, 'Daniel', 'What kind of music do you like and what app do you use?', '7:11 PM', 'assets/images/daniel.png', true),
              buildMessageTile(context, 'Laura Levy', 'Hi Tina. How\'s your night going?', '7:11 PM', 'assets/images/daniel.png', true),
              buildMessageTile(context, 'Ellen Lambert', 'Cool! let\'s meet at 16:00 near the shopping mall', '7:11 PM', 'assets/images/daniel.png', false),
              buildMessageTile(context, 'Timothy Steele', 'Yeas sure, but this is not something I like though', '7:11 PM', 'assets/images/daniel.png', false),
              buildMessageTile(context, 'Lou Quinn', 'Congrats! after all this searches you finally made it!', '7:11 PM', 'assets/images/daniel.png', false),
              buildMessageTile(context, 'Josephine Gordon', 'I\'m so tired of this day too much work to do!', '7:11 PM', 'assets/images/daniel.png', false),
              buildMessageTile(context, 'Mike', 'Do not forget to take the dog out on Thursday night', '7:11 PM', 'assets/images/daniel.png', false),
              buildMessageTile(context, 'Jessie', 'Do not forget to take the dog out on Thursday night', '7:11 PM', 'assets/images/daniel.png', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMessageTile(BuildContext context, String name, String message, String time, String imagePath, bool isUnread) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        // Navigate to ChatScreen when a message tile is tapped
        Get.to(ChatScreen(chatName: 'Daniel',)); // Using GetX for navigation
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen())); // Using default navigation
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                if (isUnread)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '16',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


