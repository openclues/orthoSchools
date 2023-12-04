part of 'interests_bloc.dart';

abstract class InterestsEvent extends Equatable {
  const InterestsEvent();

  @override
  List<Object> get props => [];
}



class LoadInterests extends InterestsEvent {
  final String userId;

  LoadInterests(this.userId);

  @override
  List<Object> get props => [userId];
}