// UserProfile model to map the data
class UserProfile {
  String userName;
  String gender;
  int age;
  List<String> preferences;
  String userPhoneNumber;
  String userEmail;
  String profession;

  UserProfile({
    this.userName = '',
    this.gender = '',
    this.age = 0,
    this.preferences = const [],
    this.userPhoneNumber = '',
    this.userEmail = '',
    this.profession = '',
  });
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'userPhoneNumber': userPhoneNumber,
      'profession': profession,
      'gender': gender,
      'age': age,

    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userName: map['userName'] ?? '',
      gender: map['gender'] ?? '',
      age: map['age'] ?? 0,
      preferences: List<String>.from(map['preferences'] ?? []),
      userPhoneNumber: map['userPhoneNumber'] ?? '',
      userEmail: map['userEmail'] ?? '',
      profession: map['profession'] ?? '',
    );
  }
}
