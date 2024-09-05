class RoomModel {
  int? id;
  String? location;
  int? rent;
  String? roomType;
  String? buildingType;
  int? user;
  String? phoneNumber;
  String? name;
  String? gender;
  int? age;
  String? foodChoice;
  bool? drinking;
  bool? smoking;
  bool? pet;

  RoomModel({
    required this.id,
    required this.location,
    required this.rent,
    required this.roomType,
    required this.buildingType,
    required this.user,
    this.phoneNumber,
    this.name,
    this.gender,
    this.age,
    this.foodChoice,
    this.drinking,
    this.smoking,
    this.pet,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      location: json['location'],
      rent: json['rent'],
      roomType: json['room_type'],
      buildingType: json['building_type'],
      user: json['user'],
      phoneNumber: json["phone_number"],
      name: json["name"],
      gender: json["gender"],
      age: json["age"],
      foodChoice: json["food_choice"],
      drinking: json["drinking"],
      smoking: json["smoking"],
      pet: json["pet"],
    );
  }
}
