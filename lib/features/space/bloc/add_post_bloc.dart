import 'dart:convert';

import 'package:azsoon/features/space/data/space_model.dart';
import 'package:azsoon/features/space/data/space_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  SpaceRepo spaceRepo = SpaceRepo();
  AddPostBloc() : super(AddPostInitial()) {
    on<AddPostToSpace>((event, emit) async {
      emit(const AddPostLoading());
      var response =
          await spaceRepo.addPost(event.spaceId, event.content, event.images , event.blogpost);
      if (response.statusCode == 201) {}
      emit(const AddPostLoaded());
    });
  }
}
