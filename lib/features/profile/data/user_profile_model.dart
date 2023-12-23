import 'dart:convert';

import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:equatable/equatable.dart';

class UserProfile extends Profile {




  
}

class UserModel extends Equatable {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  int? userRole;
  String? phone;
  String? address;
  bool? isBanned;
  bool? isSuspend;
  bool? isVerified;
  bool? isVerifiedPro;
  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.userRole,
    this.phone,
    this.address,
    this.isBanned,
    this.isSuspend,
    this.isVerified,
    this.isVerifiedPro,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'userRole': userRole,
      'phone': phone,
      'address': address,
      'isBanned': isBanned,
      'isSuspend': isSuspend,
      'isVerified': isVerified,
      'isVerifiedPro': isVerifiedPro,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt(),
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      userRole: map['userRole']?.toInt(),
      phone: map['phone'],
      address: map['address'],
      isBanned: map['isBanned'],
      isSuspend: map['isSuspend'],
      isVerified: map['isVerified'],
      isVerifiedPro: map['isVerifiedPro'],
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
      isSuspend,
      isVerified,
      isVerifiedPro,
    ];
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
