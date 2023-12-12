import 'dart:convert';

import 'package:azsoon/features/space/data/space_model.dart';
import 'package:azsoon/features/space/data/space_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'my_spaces_event.dart';
part 'my_spaces_state.dart';

class MySpacesBloc extends Bloc<MySpacesEvent, MySpacesState> {
  MySpacesBloc() : super(MySpacesInitial()) {
    SpaceRepo spaceRepo = SpaceRepo();
    on<MySpacesEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadMySpaces>((event, emit) async {
      emit(const MySpacesLoading());
      try {
        var response = await spaceRepo.getMySpaces();
        if (response.statusCode == 200) {
          List<Space> spaces = [];
          for (var item in jsonDecode(response.body)) {
            spaces.add(Space.fromJson(item));
          }
          emit(MySpacesLoaded(spaces: spaces));
        } else {
          emit(const MySpacesError(message: 'Error loading spaces'));
        }
      } catch (e) {
        emit(const MySpacesError(message: 'Error loading spaces'));
      }
    });
  }
}
