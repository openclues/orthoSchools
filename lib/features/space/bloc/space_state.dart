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
  final RecommendedSpace space;
  const SpaceLoaded(
    // this.spaceModel,
    this.space,
  );
  @override
  List<Object> get props => [space];
  //copy  with
  SpaceLoaded copyWith({
    RecommendedSpace? space,
  }) {
    return SpaceLoaded(
      space ?? this.space,
    );
  }
}
