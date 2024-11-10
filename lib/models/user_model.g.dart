// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      age: (json['age'] as num?)?.toInt(),
      location: json['location'] as String,
      foodChoice: json['foodChoice'] as String,
      drinking: json['drinking'] as bool,
      smoking: json['smoking'] as bool,
      pet: json['pet'] as bool,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'gender': instance.gender,
      'age': instance.age,
      'location': instance.location,
      'foodChoice': instance.foodChoice,
      'drinking': instance.drinking,
      'smoking': instance.smoking,
      'pet': instance.pet,
    };
