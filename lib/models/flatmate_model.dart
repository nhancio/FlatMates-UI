class FlatmateModel {
  String phoneNumber;
  String name;
  String gender;
  int age;
  String location;
  String foodChoice;
  bool drinking;
  bool smoking;
  bool pet;

  FlatmateModel({
    required this.phoneNumber,
    required this.name,
    required this.gender,
    required this.age,
    required this.location,
    required this.foodChoice,
    required this.drinking,
    required this.smoking,
    required this.pet,
  });

  // Factory method to create a FlatmateModel from JSON
  factory FlatmateModel.fromJson(Map<String, dynamic> json) {
    return FlatmateModel(
      phoneNumber: json['phone_number'],
      name: json['name'],
      gender: json['gender'],
      age: json['age'],
      location: json['location'] ?? '',
      foodChoice: json['food_choice'],
      drinking: json['drinking'],
      smoking: json['smoking'],
      pet: json['pet'],
    );
  }
}
