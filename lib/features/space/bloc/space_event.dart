


part of 'space_bloc.dart';

sealed class SpaceEvent extends Equatable {
  const SpaceEvent();

  @override
  List<Object> get props => [];
}

class LoadSpace extends SpaceEvent {
  final int id;
  const LoadSpace({required this.id});
  @override
  List<Object> get props => [];
}



class UpdateSpace extends SpaceEvent {
  final RecommendedSpace space;
  const UpdateSpace({required this.space});
  @override
  List<Object> get props => [space];
}