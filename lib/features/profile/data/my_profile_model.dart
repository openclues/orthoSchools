import 'dart:convert';

import 'package:azsoon/model/user-info.dart';

import 'user_profile_model.dart';

class Profile {
  Profile({
    this.title,
    this.bio,
    this.studyIn,
    this.cover,
    this.profileImage,
    this.birthDate,
    this.placeOfWork,
    this.speciality,
    this.isme,
    this.user,
    this.cardId,
  });

  String? title;
  String? bio;
  String? studyIn;
  String? cover;
  bool? isme;
  String? cardId;
  String? profileImage;
  DateTime? birthDate;
  String? placeOfWork;
  UserModel? user;
  String? speciality;

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        title: json["title"],
        cardId: json["card_id"],
        isme: json["is_me"],
        bio: json["bio"],
        studyIn: json["study_in"],
        user: json["user"] == null ? null : UserModel.fromMap(json["user"]),
        cover: json["cover"],
        profileImage: json["profileImage"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        placeOfWork: json["place_of_work"],
        speciality: json["speciality"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "bio": bio,
        "study_in": studyIn,
        "cover": cover,
        "profileImage": profileImage,
        "birth_date": birthDate == null
            ? null
            : "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "place_of_work": placeOfWork,
        "speciality": speciality,
      };
}

class MyProfile extends Profile {}

class UserMe {}

// I/flutter ( 8185): {"title":null,"bio":null,"study_in":null,"cover":null,"profileImage":null,"birth_date":null,"place_of_work":null,"speciality":null,"user":{"id":3,"email":"basicdentist@test.com","first_name":"string","last_name":"string","userRole":1,"phone":"","address":"","is_banned":false,"is_suspend":false,"is_verified":false,"is_verified_pro":false}}
