part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileData extends ProfileEvent {
  final int? id;

  const LoadProfileData({this.id});

  @override
  List<Object> get props => [];
}

class SetInitialProfileData extends ProfileEvent {
  final int id;

  const SetInitialProfileData({required this.id});

  @override
  List<Object> get props => [id];
}

class EditProfileEvent extends ProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? title;
  final String? bio;
  final String? email;
  final String? phone;
  final String? address;

  const EditProfileEvent(
      {this.firstName,
      this.lastName,
      this.title,
      this.bio,
      this.email,
      this.phone,
      this.address});
}
