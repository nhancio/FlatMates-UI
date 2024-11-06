/*
import 'package:flatmates/screen/chat_screen/chat_screen.dart';
import 'package:flatmates/screen/details_screen/flate_mate_details.dart';
import 'package:flatmates/screen/details_screen/room_details.dart';
import 'package:flatmates/screen/speech_text_screen.dart';
import 'package:flatmates/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flatmates/theme/app_text_styles.dart';
import 'package:flatmates/theme/app_colors.dart';
import 'package:get/get.dart';

class Search_details extends StatefulWidget {
  @override
  _Search_detailsState createState() => _Search_detailsState();
}

class _Search_detailsState extends State<Search_details> with SingleTickerProviderStateMixin {

  late bool isDarkMode;
    late TabController _tabController;

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
          ListView(
            children: [
              _buildMatchTile(
                context,
                'Daniel',
                26,
                'Artist',
                'Gachibowli, Hyderabad',
                'assets/images/man.png',
              ),
              _buildMatchTile(
                context,
                'Sara',
                24,
                'Athlete',
                'Madhapur, Hyderabad',
                'assets/images/man.png',
              ),
              _buildMatchTile(
                context,
                'Mike',
                27,
                'Traveler',
                'Jubilee Hills, Hyderabad',
                'assets/images/man.png',
              ),
              _buildMatchTile(
                context,
                'Andera',
                26,
                'Dancer',
                'Hyderabad',
                'assets/images/man.png',
              ),
            ],
          ),
                    ListView(
            children: [
              _buildMatchTile(
                context,
                'Daniel',
                26,
                'Artist',
                'Gachibowli, Hyderabad',
                'assets/images/man.png',
              ),
              _buildMatchTile(
                context,
                'Sara',
                24,
                'Athlete',
                'Madhapur, Hyderabad',
                'assets/images/man.png',
              ),
              _buildMatchTile(
                context,
                'Mike',
                27,
                'Traveler',
                'Jubilee Hills, Hyderabad',
                'assets/images/man.png',
              ),
              _buildMatchTile(
                context,
                'Andera',
                26,
                'Dancer',
                'Hyderabad',
                'assets/images/man.png',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatchTile(BuildContext context, String name, int age,
      String profession, String location, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightCardBackground
          : AppColors.darkCardBackground,
      child: InkWell(
        onTap: () {
          Get.to(() => FlateMateDetails());
        },
        borderRadius: BorderRadius.circular(15), // This will match the Card's border radius
        child: ListTile(
          contentPadding: EdgeInsets.all(15),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
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
              Get.to(() => ChatScreen(chatName: name));
            },
          ),
        ),
      ),
    );
  }

  }

*/
