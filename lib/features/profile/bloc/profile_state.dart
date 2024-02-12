part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profileModel;
  const ProfileLoaded({required this.profileModel});

  @override
  List<Object> get props => [profileModel];

  ProfileLoaded copyWith({
    Profile? profileModel,
  }) {
    return ProfileLoaded(
      profileModel: profileModel ?? this.profileModel,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}


class ProfileIsNotSignedIn extends ProfileState {
  const ProfileIsNotSignedIn();
}
