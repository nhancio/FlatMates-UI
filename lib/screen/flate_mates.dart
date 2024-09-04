import 'package:flatmates/controllers/flat_controller.dart';
import 'package:flatmates/controllers/room_controller.dart';
import 'package:flatmates/screen/chat_screen/chat_screen.dart';
import 'package:flatmates/screen/details_screen/flate_mate_details.dart';
import 'package:flatmates/screen/details_screen/room_details.dart';
import 'package:flatmates/screen/speech_text_screen.dart';
import 'package:flatmates/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:get/get.dart';

class FlatmateRoomScreen extends StatefulWidget {
  @override
  _FlatmateRoomScreenState createState() => _FlatmateRoomScreenState();
}

class _FlatmateRoomScreenState extends State<FlatmateRoomScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late bool isDarkMode;
    final FlatController flatController = Get.put(FlatController());
    final RoomController roomController = Get.put(RoomController());


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


  Future<void> _refreshFlatmateList() async {
    // Call the function in the controller to refresh the data
    flatController.fetchFlatmates(); // Assuming you have a method for fetching the flatmates
  }

  Future<void> _refreshRoomList() async {
    // Call the function in the controller to refresh the data
    roomController.fetchRooms(); // Assuming you have a method for fetching the flatmates
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () {
            Get.to(() => BottomNavigation());
          },
        ),
        title: Text('Your Matches', style: AppTextStyles.titleStyle(context)),
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
          // Flatmate Tab
        Obx(() {
            if (flatController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return RefreshIndicator(
                onRefresh: _refreshFlatmateList,
                child: ListView.builder(
                  itemCount: flatController.flatmatesList.length,
                  itemBuilder: (context, index) {
                    return _buildMatchTile(
                      context,
                      name: flatController.flatmatesList[index].name,
                      age: flatController.flatmatesList[index].age,
                    );
                  },
                ),
              );
            }
          }),
          // Room Tab
          Obx(() {
            if (roomController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return RefreshIndicator(
                                onRefresh: _refreshRoomList,
                child: ListView.builder(
                  itemCount: roomController.roomList.length,
                  itemBuilder: (context, index) {
                    final room = roomController.roomList[index];
                    return _buildRoomTile(
                      context,
                      sharing: room.roomType,
                      rent:  room.rent.toString(),
                     location: room.location,
                      profession: room.buildingType,
                    );
                  },
                ),
              );
            }
          })
        ],
      ),
    );
  }

  Widget _buildMatchTile(BuildContext context, {String? name, int? age,
      String? profession, String? location, String? imagePath}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightCardBackground
          : AppColors.darkCardBackground,
      child: InkWell(
        onTap: () {
          Get.to(() => FlateMateDetails());
        },
        borderRadius: BorderRadius.circular(15), // This will match the Card's border radius
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          leading: imagePath!=null ? CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ) : const SizedBox(),
          title: Text(
            'Name: $name',
            style: AppTextStyles.bodyStyle(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Age: $age', style: AppTextStyles.subTextStyle(context)),
              Text('Profession: $profession',
                  style: AppTextStyles.subTextStyle(context)),
              Text('Location: $location',
                  style: AppTextStyles.subTextStyle(context)),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: isDarkMode ? Colors.purpleAccent : Colors.purple),
            onPressed: () {
              Get.to(() => ChatScreen(chatName: "$name"));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRoomTile(BuildContext context,{ String? sharing, String ?rent,
      String? profession, String? location, String? imagePath}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightCardBackground
          : AppColors.darkCardBackground,
      child: InkWell(
        onTap: () {
          Get.to(() => RoomProfileScreen());
        },
        borderRadius: BorderRadius.circular(15), // This will match the Card's border radius
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          leading: imagePath != null ? CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ) : const SizedBox(),
          title: Text(
            'Sharing: $sharing',
            style: AppTextStyles.bodyStyle(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rent: $rent', style: AppTextStyles.subTextStyle(context)),
              Text('Profession: $profession',
                  style: AppTextStyles.subTextStyle(context)),
              Text('Location: $location',
                  style: AppTextStyles.subTextStyle(context)),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: isDarkMode ? Colors.purpleAccent : Colors.purple),
            onPressed: () {
              Get.to(() => ChatScreen(chatName: "$sharing"));
            },
          ),
        ),
      ),
    );
  }
}
