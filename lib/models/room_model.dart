class RoomModel {
  int id;
  String location;
  int rent;
  String roomType;
  String buildingType;
  int user;

  RoomModel({
    required this.id,
    required this.location,
    required this.rent,
    required this.roomType,
    required this.buildingType,
    required this.user,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      location: json['location'],
      rent: json['rent'],
      roomType: json['room_type'],
      buildingType: json['building_type'],
      user: json['user'],
    );
  }
}
