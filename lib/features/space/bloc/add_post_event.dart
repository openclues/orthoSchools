part of 'add_post_bloc.dart';

sealed class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object> get props => [];
}


class AddPostToSpace extends AddPostEvent {
  final String content;
  final String spaceId;
  final List<XFile> images;
  final int? blogpost;
  const AddPostToSpace(
      {required this.content, required this.spaceId, required this.images, this.blogpost});
  @override
  List<Object> get props => [content, spaceId];
}