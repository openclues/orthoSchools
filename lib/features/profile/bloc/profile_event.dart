part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}



class LoadProfileData extends ProfileEvent {
  final int? id;
  

  const LoadProfileData({ this.id});

  @override
  List<Object> get props => [];
}


class SetInitialProfileData extends ProfileEvent {
  final int id;

  const SetInitialProfileData({required this.id});

  @override
  List<Object> get props => [id];
}

