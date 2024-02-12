part of 'join_space_bloc.dart';

sealed class JoinSpaceState extends Equatable {
  const JoinSpaceState();
  
  @override
  List<Object> get props => [];
}

final class JoinSpaceInitial extends JoinSpaceState {}



 class JoinSpaceLoading extends JoinSpaceState {
  final int spaceId;
  const JoinSpaceLoading({required this.spaceId});
}



final class JoinSpaceSuccess extends JoinSpaceState {
  final int spaceId;
  final SimpleSpace space;
  const JoinSpaceSuccess({required this.spaceId , required this.space});
}




final class JoinSpaceError extends JoinSpaceState {
  final String message;
  const JoinSpaceError({required this.message});
}
