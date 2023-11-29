// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MoreInfo MoreInfoFromJson(String str) => MoreInfo.fromJson(json.decode(str));

String MoreInfoToJson(MoreInfo data) => json.encode(data.toJson());

class MoreInfo {
  final int id;
  final User user;
  final dynamic bio;
  final dynamic cover;
  final dynamic profileImage;
  final dynamic placeOfWork;
  final dynamic speciality;
  final dynamic selfie;

  MoreInfo({
    required this.id,
    required this.user,
    required this.bio,
    required this.cover,
    required this.profileImage,
    required this.placeOfWork,
    required this.speciality,
    required this.selfie,
  });

  factory MoreInfo.fromJson(Map<String, dynamic> json) => MoreInfo(
        id: json["id"],
        user: User.fromJson(json["user"]),
        bio: json["bio"],
        cover: json["cover"],
        profileImage: json["profileImage"],
        placeOfWork: json["place_of_work"],
        speciality: json["speciality"],
        selfie: json["selfie"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
        "bio": bio,
        "cover": cover,
        "profileImage": profileImage,
        "place_of_work": placeOfWork,
        "speciality": speciality,
        "selfie": selfie,
      };
}

class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final bool isActive;
  final DateTime lastLogin;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.isActive,
    required this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        address: json["address"],
        isActive: json["is_active"],
        lastLogin: DateTime.parse(json["last_login"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "address": address,
        "is_active": isActive,
        "last_login": lastLogin.toIso8601String(),
      };
}
