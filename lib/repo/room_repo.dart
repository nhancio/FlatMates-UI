import 'package:flatmates/models/room_model.dart';
import 'package:flatmates/network/network_service.dart';

class RoomRepo {
  Future<List<RoomModel>> fetchRooms() async {
    try {
      final response = await NetworkService().getRequest(
        '/recommendations_rooms/',
      ); // Replace with your actual API URL
      if (response.statusCode == 200) {
        List<RoomModel> rooms = (response.data as List)
            .map((roomJson) => RoomModel.fromJson(roomJson))
            .toList();
        return rooms;
      } else {
        throw Exception('Failed to load rooms');
      }
    } catch (e) {
      print("response.statusCode");
      print(e.toString());
      throw Exception('Failed to load rooms: $e');
    }
  }

  Future<void> addRoomDetails(
      {String? location,
      int? rent,
      String? roomType,
      String? buildingType}) async {
    try {
      var body = {
        'location': location,
        'rent': rent,
        'room_type': roomType,
        'building_type': buildingType,
      };

      final response =
          await NetworkService().postRequest('/create_room_details/', body); //
      print("response.statusCode");
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw Exception('Failed to add room details');
      }
    } catch (e) {
      throw Exception('Error adding room details: $e');
    }
  }
}
