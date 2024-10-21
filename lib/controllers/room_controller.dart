/*
import 'package:flatmates/models/room_model.dart';
import 'package:flatmates/repo/room_repo.dart';
import 'package:flatmates/widgets/bottomBar.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  RoomController();

  var isLoading = true.obs;
  var roomList = <RoomModel>[].obs;

  @override
  void onInit() {
    fetchRooms();
    super.onInit();
  }

  void fetchRooms() async {
    try {
      isLoading(true);
      var rooms = await RoomRepo().fetchRooms();
      roomList.value = rooms;
    } catch (e) {
      // Get.snackbar('Error', 'Failed to load rooms');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addRoomDetails({
    required String location,
    required int rent,
    required String roomType,
    required String buildingType,
    required bool isRoomAvailable,
  }) async {
    isLoading(true);
    try {
      await RoomRepo().addRoomDetails(
          buildingType: buildingType,
          location: location,
          rent: rent,
          roomType: roomType);
      Get.snackbar('Success', 'Room details added successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
      fetchRooms();
      Get.to(() => BottomNavigation());
    }
  }
}
*/
