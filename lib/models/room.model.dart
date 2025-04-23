import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  String id;
  // Address Package
  String buildingName;
  String locality;
  String city;
  // Property Details
  String homeType;
  String furnishType;
  String roomsAvailable;
  String roomType;
  String washroomType;
  String parkingType;
  String societyType;
  String moveInDate;
  String occupationPerRoom;
  String roomRent;
  String userId;
  Timestamp? createdAt;
  List<String> selectedValues;
  List<String> amenities;
  // Tenant Preferences
  String preferredTenant;
  List<String> tenantPreferences;
  // Contact Info
  String ownerName;
  String mobileNumber;
  // Additional Bills
  String wifiBill;
  String waterBill;
  String gasBill;
  // Service Costs
  String maidCost;
  String cookCost;
  String otherCosts;

  Room({
    required this.id,
    required this.buildingName,
    required this.locality,
    required this.city,
    required this.homeType,
    required this.furnishType,
    required this.roomsAvailable,
    required this.roomType,
    required this.washroomType,
    required this.parkingType,
    required this.societyType,
    required this.moveInDate,
    required this.occupationPerRoom,
    required this.roomRent,
    required this.userId,
    this.createdAt,
    required this.selectedValues,
    required this.amenities,
    required this.preferredTenant,
    required this.tenantPreferences,
    required this.ownerName,
    required this.mobileNumber,
    this.wifiBill = '0',
    this.waterBill = '0',
    this.gasBill = '0',
    this.maidCost = '0',
    this.cookCost = '0',
    this.otherCosts = '0',
  });

  Map<String, dynamic> toMap() {
    return {
      'buildingName': buildingName,
      'locality': locality,
      'city': city,
      'homeType': homeType,
      'furnishType': furnishType,
      'roomsAvailable': roomsAvailable,
      'roomType': roomType,
      'washroomType': washroomType,
      'parkingType': parkingType,
      'societyType': societyType,
      'moveInDate': moveInDate,
      'occupationPerRoom': occupationPerRoom,
      'roomRent': roomRent,
      'userId': userId,
      'createdAt': createdAt,
      'selectedValues': selectedValues,
      'amenities': amenities,
      'preferredTenant': preferredTenant,
      'tenantPreferences': tenantPreferences,
      'ownerName': ownerName,
      'mobileNumber': mobileNumber,
      'wifiBill': wifiBill,
      'waterBill': waterBill,
      'gasBill': gasBill,
      'maidCost': maidCost,
      'cookCost': cookCost,
      'otherCosts': otherCosts,
    };
  }

  factory Room.fromMap(String id, Map<String, dynamic> map) {
    return Room(
      id: id,
      buildingName: map['buildingName'] ?? '',
      locality: map['locality'] ?? '',
      city: map['city'] ?? '',
      homeType: map['homeType'] ?? '',
      furnishType: map['furnishType'] ?? '',
      roomsAvailable: map['roomsAvailable'] ?? '',
      roomType: map['roomType'] ?? '',
      washroomType: map['washroomType'] ?? '',
      parkingType: map['parkingType'] ?? '',
      societyType: map['societyType'] ?? '',
      moveInDate: map['moveInDate'] ?? '',
      occupationPerRoom: map['occupationPerRoom'] ?? '',
      roomRent: map['roomRent'] ?? '',
      userId: map['userId'] ?? '',
      createdAt: map['createdAt'],
      selectedValues: List<String>.from(map['selectedValues'] ?? []),
      amenities: List<String>.from(map['amenities'] ?? []),
      preferredTenant: map['preferredTenant'] ?? '',
      tenantPreferences: List<String>.from(map['tenantPreferences'] ?? []),
      ownerName: map['ownerName'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      wifiBill: map['wifiBill'] ?? '0',
      waterBill: map['waterBill'] ?? '0',
      gasBill: map['gasBill'] ?? '0',
      maidCost: map['maidCost'] ?? '0',
      cookCost: map['cookCost'] ?? '0',
      otherCosts: map['otherCosts'] ?? '0',
    );
  }

  Room copyWith({
    String? buildingName,
    String? locality,
    String? city,
    String? homeType,
    String? furnishType,
    String? roomsAvailable,
    String? roomType,
    String? washroomType,
    String? parkingType,
    String? societyType,
    String? moveInDate,
    String? occupationPerRoom,
    String? roomRent,
    String? userId,
    Timestamp? createdAt,
    List<String>? selectedValues,
    List<String>? amenities,
    String? preferredTenant,
    List<String>? tenantPreferences,
    String? ownerName,
    String? mobileNumber,
    String? wifiBill,
    String? waterBill,
    String? gasBill,
    String? maidCost,
    String? cookCost,
    String? otherCosts,
  }) {
    return Room(
      id: this.id,
      buildingName: buildingName ?? this.buildingName,
      locality: locality ?? this.locality,
      city: city ?? this.city,
      homeType: homeType ?? this.homeType,
      furnishType: furnishType ?? this.furnishType,
      roomsAvailable: roomsAvailable ?? this.roomsAvailable,
      roomType: roomType ?? this.roomType,
      washroomType: washroomType ?? this.washroomType,
      parkingType: parkingType ?? this.parkingType,
      societyType: societyType ?? this.societyType,
      moveInDate: moveInDate ?? this.moveInDate,
      occupationPerRoom: occupationPerRoom ?? this.occupationPerRoom,
      roomRent: roomRent ?? this.roomRent,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      selectedValues: selectedValues ?? this.selectedValues,
      amenities: amenities ?? this.amenities,
      preferredTenant: preferredTenant ?? this.preferredTenant,
      tenantPreferences: tenantPreferences ?? this.tenantPreferences,
      ownerName: ownerName ?? this.ownerName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      wifiBill: wifiBill ?? this.wifiBill,
      waterBill: waterBill ?? this.waterBill,
      gasBill: gasBill ?? this.gasBill,
      maidCost: maidCost ?? this.maidCost,
      cookCost: cookCost ?? this.cookCost,
      otherCosts: otherCosts ?? this.otherCosts,
    );
  }
}
