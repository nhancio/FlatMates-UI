import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  String id;
  String address;
  String homeType;
  String moveInDate;
  String occupationPerRoom;
  String roomRent;
  String roomType;
  String userId;
  Timestamp? createdAt;
  List<String> selectedValues;

  Room({
    required this.id,
    required this.address,
    required this.homeType,
    required this.moveInDate,
    required this.occupationPerRoom,
    required this.roomRent,
    required this.roomType,
    required this.userId,
    this.createdAt,
    required this.selectedValues,
  });

  // Convert Room to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'homeType': homeType,
      'moveInDate': moveInDate,
      'occupationPerRoom': occupationPerRoom,
      'roomRent': roomRent,
      'roomType': roomType,
      'userId': userId,
      'createdAt': createdAt,
      'selectedValues': selectedValues,
    };
  }

  // Convert Firestore Map to Room
  factory Room.fromMap(String id, Map<String, dynamic> map) {
    return Room(
      id: id,
      address: map['address'],
      homeType: map['homeType'],
      moveInDate: map['moveInDate'],
      occupationPerRoom: map['occupationPerRoom'],
      roomRent: map['roomRent'],
      roomType: map['roomType'],
      userId: map['userId'],
      createdAt: map['createdAt'],
      selectedValues: List<String>.from(map['selectedValues'] ?? []),

    );
  }

  // Copy method for updating the room
  Room copyWith({
    String? address,
    String? homeType,
    String? moveInDate,
    String? occupationPerRoom,
    String? roomRent,
    String? roomType,
    String? userId,
    Timestamp? createdAt,
    List<String>? selectedValues,

  }) {
    return Room(
      id: this.id,
      address: address ?? this.address,
      homeType: homeType ?? this.homeType,
      moveInDate: moveInDate ?? this.moveInDate,
      occupationPerRoom: occupationPerRoom ?? this.occupationPerRoom,
      roomRent: roomRent ?? this.roomRent,
      roomType: roomType ?? this.roomType,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      selectedValues: selectedValues ?? this.selectedValues,

    );
  }
}
