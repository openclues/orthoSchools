import 'dart:convert';

import 'package:azsoon/features/profile/presentation/screens/create_blog_screen.dart';
import 'package:equatable/equatable.dart';

import '../../blog/data/models/articles_model.dart';
import 'user_profile_model.dart';

class Profile extends Equatable {
  const Profile({
    this.title,
    this.bio,
    this.blog,
    this.studyIn,
    this.cover,
    this.profileImage,
    this.birthDate,
    this.placeOfWork,
    this.selfie,
    this.speciality,
    this.isme,
    this.certificates,
    this.verifiedProRequest,
    this.user,
    this.isCompleted,
    this.notificationsCount,
    this.cardId,
    this.daysLeft,
    this.city,
    this.country,
    this.state,
  });

  final String? title;
  final String? bio;
  final String? studyIn;
  final String? cover;
  final String? selfie;
  final VerifiedProRequest? verifiedProRequest;
  final bool? isme;
  final BlogsModel? blog;
  final String? cardId;
  final String? country;
  final String? state;
  final bool? isCompleted;
  final int? notificationsCount;
  final String? city;
  final String? profileImage;
  final DateTime? birthDate;
  final List<Certifcate>? certificates;
  final String? placeOfWork;
  final UserModel? user;
  final String? daysLeft;
  final String? speciality;

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        title: json["title"],
        cardId: json["id_card"],
        isme: json["is_me"],
        city: json["city"],
        country: json["country"],
        notificationsCount: json["unread_notifications"],
        state: json["state"],
        verifiedProRequest: json["verified_pro_request"] == null
            ? null
            : VerifiedProRequest.fromJson(json["verified_pro_request"]),
        selfie: json["selfie"],
        certificates: json["certificates"] == null
            ? null
            : List<Certifcate>.from(
                json["certificates"].map((x) => Certifcate.fromJson(x))),
        bio: json["bio"],
        studyIn: json["study_in"],
        blog: json["blog"] == null ? null : BlogsModel.fromJson(json["blog"]),
        user: json["user"] == null ? null : UserModel.fromMap(json["user"]),
        cover: json["cover"],
        profileImage: json["profileImage"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        placeOfWork: json["place_of_work"],
        speciality: json["speciality"],
        isCompleted: isCompletedprofile(
          title: json["title"],
          bio: json["bio"],
          studyIn: json["study_in"],
          cover: json["cover"],
          profileImage: json["profileImage"],
          birthDate: json["birth_date"] == null
              ? null
              : DateTime.parse(json["birth_date"]),
          placeOfWork: json["place_of_work"],
          speciality: json["speciality"],
        ),
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

  @override
  List<Object?> get props => [
        title,
        bio,
        studyIn,
        cover,
        profileImage,
        birthDate,
        placeOfWork,
        speciality,
        isme,
        user,
        cardId,
        certificates,
        selfie
      ];

  Profile copyWith({
    String? title,
    String? bio,
    String? studyIn,
    String? cover,
    bool? isme,
    int? notificationsCount,
    String? cardId,
    String? profileImage,
    DateTime? birthDate,
    String? placeOfWork,
    UserModel? user,
    String? speciality,
    BlogsModel? blog,
  }) {
    return Profile(
      title: title ?? this.title,
      bio: bio ?? this.bio,
      studyIn: studyIn ?? this.studyIn,
      cover: cover ?? this.cover,
      blog: blog ?? this.blog,
      notificationsCount: notificationsCount ?? this.notificationsCount,
      isme: isme ?? this.isme,
      cardId: cardId ?? this.cardId,
      profileImage: profileImage ?? this.profileImage,
      birthDate: birthDate ?? this.birthDate,
      placeOfWork: placeOfWork ?? this.placeOfWork,
      user: user ?? this.user,
      speciality: speciality ?? this.speciality,
    );
  }
}

bool isCompletedprofile(
    {String? title,
    String? bio,
    String? studyIn,
    String? cover,
    String? profileImage,
    DateTime? birthDate,
    String? placeOfWork,
    String? speciality}) {
  if (title == null ||
      bio == null ||
      studyIn == null ||
      cover == null ||
      profileImage == null ||
      birthDate == null ||
      placeOfWork == null ||
      speciality == null ||
      title.isEmpty ||
      bio.isEmpty ||
      studyIn.isEmpty ||
      cover.isEmpty ||
      profileImage.isEmpty ||
      placeOfWork.isEmpty ||
      speciality.isEmpty) {
    return false;
  }
  return true;
}

// I/flutter ( 8185): {"title":null,"bio":null,"study_in":null,"cover":null,"profileImage":null,"birth_date":null,"place_of_work":null,"speciality":null,"user":{"id":3,"email":"basicdentist@test.com","first_name":"string","last_name":"string","userRole":1,"phone":"","address":"","is_banned":false,"is_suspend":false,"is_verified":false,"is_verified_pro":false}}
class Certifcate {
  int? id;
  String? title;
  String? certificateFile;
  Certifcate({
    this.id,
    this.title,
    this.certificateFile,
  });

  //from json
  factory Certifcate.fromJson(Map<String, dynamic> json) => Certifcate(
        id: json["id"],
        title: json["title"],
        certificateFile: json["certificate_file"],
      );
}

class VerifiedProRequest {
  final int? id;
  final String? status;
  final Profile? profile;

  VerifiedProRequest({required this.id, required this.status, this.profile});

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };

  factory VerifiedProRequest.fromJson(Map<String, dynamic> json) =>
      VerifiedProRequest(
        id: json["id"],
        status: json["requestStatus"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );
}
