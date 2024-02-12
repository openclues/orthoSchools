part of 'user_profile_cubit_cubit.dart';

sealed class UserProfileCubitState extends Equatable {
  const UserProfileCubitState();

  @override
  List<Object> get props => [];
}

final class UserProfileCubitInitial extends UserProfileCubitState {}



class UserProfileLoaded extends UserProfileCubitState {
  final Profile profileModel;
  const UserProfileLoaded({required this.profileModel});

  @override
  List<Object> get props => [profileModel];

  UserProfileLoaded copyWith({
    Profile? profileModel,
  }) {
    return UserProfileLoaded(
      profileModel: profileModel ?? this.profileModel,
    );
  }
}


class UserProfileError extends UserProfileCubitState {
  final String message;

  const UserProfileError({required this.message});

  @override
  List<Object> get props => [message];
}


class UserProfileLoading extends UserProfileCubitState {
  const UserProfileLoading();
}