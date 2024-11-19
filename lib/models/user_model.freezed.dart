// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get phone_number => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get foodChoice => throw _privateConstructorUsedError;
  bool? get drinking => throw _privateConstructorUsedError;
  bool? get smoking => throw _privateConstructorUsedError;
  bool? get pet => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String phone_number,
      String name,
      String gender,
      int? age,
      String? location,
      String? foodChoice,
      bool? drinking,
      bool? smoking,
      bool? pet});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone_number = null,
    Object? name = null,
    Object? gender = null,
    Object? age = freezed,
    Object? location = freezed,
    Object? foodChoice = freezed,
    Object? drinking = freezed,
    Object? smoking = freezed,
    Object? pet = freezed,
  }) {
    return _then(_value.copyWith(
      phone_number: null == phone_number
          ? _value.phone_number
          : phone_number // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      foodChoice: freezed == foodChoice
          ? _value.foodChoice
          : foodChoice // ignore: cast_nullable_to_non_nullable
              as String?,
      drinking: freezed == drinking
          ? _value.drinking
          : drinking // ignore: cast_nullable_to_non_nullable
              as bool?,
      smoking: freezed == smoking
          ? _value.smoking
          : smoking // ignore: cast_nullable_to_non_nullable
              as bool?,
      pet: freezed == pet
          ? _value.pet
          : pet // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String phone_number,
      String name,
      String gender,
      int? age,
      String? location,
      String? foodChoice,
      bool? drinking,
      bool? smoking,
      bool? pet});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone_number = null,
    Object? name = null,
    Object? gender = null,
    Object? age = freezed,
    Object? location = freezed,
    Object? foodChoice = freezed,
    Object? drinking = freezed,
    Object? smoking = freezed,
    Object? pet = freezed,
  }) {
    return _then(_$UserImpl(
      phone_number: null == phone_number
          ? _value.phone_number
          : phone_number // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      foodChoice: freezed == foodChoice
          ? _value.foodChoice
          : foodChoice // ignore: cast_nullable_to_non_nullable
              as String?,
      drinking: freezed == drinking
          ? _value.drinking
          : drinking // ignore: cast_nullable_to_non_nullable
              as bool?,
      smoking: freezed == smoking
          ? _value.smoking
          : smoking // ignore: cast_nullable_to_non_nullable
              as bool?,
      pet: freezed == pet
          ? _value.pet
          : pet // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  _$UserImpl(
      {required this.phone_number,
      required this.name,
      required this.gender,
      required this.age,
      this.location,
      this.foodChoice,
      this.drinking,
      this.smoking,
      this.pet});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String phone_number;
  @override
  final String name;
  @override
  final String gender;
  @override
  final int? age;
  @override
  final String? location;
  @override
  final String? foodChoice;
  @override
  final bool? drinking;
  @override
  final bool? smoking;
  @override
  final bool? pet;

  @override
  String toString() {
    return 'User(phone_number: $phone_number, name: $name, gender: $gender, age: $age, location: $location, foodChoice: $foodChoice, drinking: $drinking, smoking: $smoking, pet: $pet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.phone_number, phone_number) ||
                other.phone_number == phone_number) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.foodChoice, foodChoice) ||
                other.foodChoice == foodChoice) &&
            (identical(other.drinking, drinking) ||
                other.drinking == drinking) &&
            (identical(other.smoking, smoking) || other.smoking == smoking) &&
            (identical(other.pet, pet) || other.pet == pet));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phone_number, name, gender, age,
      location, foodChoice, drinking, smoking, pet);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  factory _User(
      {required final String phone_number,
      required final String name,
      required final String gender,
      required final int? age,
      final String? location,
      final String? foodChoice,
      final bool? drinking,
      final bool? smoking,
      final bool? pet}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get phone_number;
  @override
  String get name;
  @override
  String get gender;
  @override
  int? get age;
  @override
  String? get location;
  @override
  String? get foodChoice;
  @override
  bool? get drinking;
  @override
  bool? get smoking;
  @override
  bool? get pet;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
