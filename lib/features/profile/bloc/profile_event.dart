part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

// class LoadProfileData extends ProfileEvent {
//   final int? id;
//   final ProfileLoaded? profileLoaded;

//   const LoadProfileData({this.id, this.profileLoaded});

//   @override
//   List<Object> get props => [];
// }

class SetInitialProfileData extends ProfileEvent {
  final int id;

  const SetInitialProfileData({required this.id});

  @override
  List<Object> get props => [id];
}

class EditProfileEvent extends ProfileEvent {
  final ProfileLoaded profileLoaded;

  final String? firstName;
  final String? lastName;
  final String? title;
  final String? bio;
  final String? email;
  final String? phone;
  final String? address;
  final XFile? cardId;

  const EditProfileEvent(
      {this.firstName,
      this.cardId,
      this.lastName,
      required this.profileLoaded,
      this.title,
      this.bio,
      this.email,
      this.phone,
      this.address});
}

class LoadMyProfile extends ProfileEvent {
  final bool withputLoading;
  const LoadMyProfile({this.withputLoading = true});

  @override
  List<Object> get props => [];
}

class UpdateProfileLocally extends ProfileEvent {
  final Profile newProfile;
  final ProfileLoaded profileLoaded;

  const UpdateProfileLocally(
      {required this.profileLoaded, required this.newProfile});

  @override
  List<Object> get props => [profileLoaded];
}
