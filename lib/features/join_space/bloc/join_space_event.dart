part of 'join_space_bloc.dart';

sealed class JoinSpaceEvent extends Equatable {
  const JoinSpaceEvent();

  @override
  List<Object> get props => [];
}


class JoinSpace extends JoinSpaceEvent {

  final int spaceId;
  const JoinSpace({required this.spaceId});
  @override
  List<Object> get props => [spaceId];
}