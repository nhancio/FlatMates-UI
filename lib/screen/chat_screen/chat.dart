/*
import 'package:flatmates/screen/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:get/get.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats', style: AppTextStyles.titleStyle(context)),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.purple,
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Flatmate'),
            Tab(text: 'Room'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: [

              ChatScreen(chatName: '',),
            ],
          ),
          ListView(
            children: [
              ChatScreen(chatName: '',),
            ],
          ),
        ],
      ),
    );
  }


}
*/
