part of 'my_spaces_bloc.dart';

sealed class MySpacesEvent extends Equatable {
  const MySpacesEvent();

  @override
  List<Object> get props => [];
}

class LoadMySpaces extends MySpacesEvent {
  const LoadMySpaces();
  @override
  List<Object> get props => [];
}

class AddPostEvent extends MySpacesEvent {
  final String content;
  final String spaceId;
  final List<XFile> images;
  const AddPostEvent(
      {required this.content, required this.spaceId, required this.images});
  @override
  List<Object> get props => [content, spaceId];
}
