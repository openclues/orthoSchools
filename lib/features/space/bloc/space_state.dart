part of 'space_bloc.dart';

sealed class SpaceState extends Equatable {
  const SpaceState();

  @override
  List<Object> get props => [];
}

final class SpaceInitial extends SpaceState {}

class SpaceLoading extends SpaceState {
  const SpaceLoading();
  @override
  List<Object> get props => [];
}

class SpaceLoaded extends SpaceState {
  // final Space spaceModel;
  final Space space;
  const SpaceLoaded(
    // this.spaceModel,
    this.space,
  );
  @override
  List<Object> get props => [space];
}
