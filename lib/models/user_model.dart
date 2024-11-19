import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  factory User(
      {required String phone_number,
      required String name,
      required String gender,
      required int? age,
      String? location,
      String? foodChoice,
      bool? drinking,
      bool? smoking,
      bool? pet}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
