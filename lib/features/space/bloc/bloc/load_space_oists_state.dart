part of 'load_space_oists_bloc.dart';

sealed class LoadSpaceOistsState extends Equatable {
  const LoadSpaceOistsState();
  
  @override
  List<Object> get props => [];
}

final class LoadSpaceOistsInitial extends LoadSpaceOistsState {}


final class LoadSpaceLoaded extends LoadSpaceOistsState {
  final List<PostModel> posts;
  const LoadSpaceLoaded({required this.posts});
}
final class LoadSpaceError extends LoadSpaceOistsState {
  final String message;
  const LoadSpaceError({required this.message});
}

class LoadSpacePostsLoading extends LoadSpaceOistsState {}

