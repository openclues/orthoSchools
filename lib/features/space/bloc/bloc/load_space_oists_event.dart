part of 'load_space_oists_bloc.dart';

sealed class LoadSpaceOistsEvent extends Equatable {
  const LoadSpaceOistsEvent();

  @override
  List<Object> get props => [];
}

class LoadSpaceOists extends LoadSpaceOistsEvent {
  final int? spaceId;
  final String? filter;
  LoadSpaceOists(this.spaceId, this.filter);

  @override
  List<Object> get props => [];
}
