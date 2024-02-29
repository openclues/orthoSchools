import 'dart:convert';

import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:equatable/equatable.dart';

class UserProfile extends Profile {}

class UserModel extends Equatable {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  bool? emailVerified;
  bool? phoneVerified;
  List<String>? permissions;
  List<String>? groups;

  int? userRole;
  String? phone;
  String? address;
  bool? isBanned;
  bool? isSuspend;
  bool? isStuff;
  bool? isSuperUser;

  bool? isVerified;
  int? daysLeft;
  bool? isVerifiedPro;

  UserModel({
    this.id,
    this.emailVerified,
    this.phoneVerified,
    this.email,
    this.firstName,
    this.groups,
    this.permissions,
    this.isStuff,
    this.isSuperUser,
    this.lastName,
    this.userRole,
    this.daysLeft,
    this.phone,
    this.address,
    this.isBanned,
    this.isSuspend,
    this.isVerified,
    this.isVerifiedPro,
  });

  Map<String, dynamic> toMap() {
    // print(json['is_stuf']);
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'userRole': userRole,
      'phone': phone,
      'address': address,
      'daysLeft': daysLeft,
      'isBanned': isBanned,
      'isSuspend': isSuspend,
      'isVerified': isVerified,
      'isVerifiedPro': isVerifiedPro,
    };
  }

  //copy with
  UserModel copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    int? userRole,
    String? phone,
    String? address,
    int? daysLeft,
    bool? isBanned,
    bool? emailVerified,
    bool? isSuspend,
    bool? isVerified,
    bool? isVerifiedPro,
  }) {
    return UserModel(
      emailVerified: emailVerified ?? this.emailVerified,
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userRole: userRole ?? this.userRole,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      daysLeft: daysLeft ?? this.daysLeft,
      isBanned: isBanned ?? this.isBanned,
      isSuspend: isSuspend ?? this.isSuspend,
      isVerified: isVerified ?? this.isVerified,
      isVerifiedPro: isVerifiedPro ?? this.isVerifiedPro,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    print(map['is_staff']);
    print(map['permissions']);
    print(map['is_superuser']);
    return UserModel(
      id: map['id']?.toInt(),
      email: map['email'],
      daysLeft: map['days_left']?.toInt(),
      firstName: map['first_name'],
      emailVerified: map['email_verified'],
      isStuff: map['is_staff'],
      isSuperUser: map['is_superuser'],
      permissions: List<String>.from(map['permissions']),
      groups: List<String>.from(map['groups']),
      phoneVerified: map['phone_verified'],
      lastName: map['last_name'],
      userRole: map['userRole']?.toInt(),
      phone: map['phone'],
      address: map['address'],
      isBanned: map['isBanned'],
      isSuspend: map['is_suspend'],
      isVerified: map['is_verified'],
      isVerifiedPro: map['is_verified_pro'],
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      email,
      firstName,
      lastName,
      userRole,
      phone,
      address,
      isBanned,
      emailVerified,
      isSuspend,
      isVerified,
      isVerifiedPro,
    ];
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
