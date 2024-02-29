import 'dart:convert';

import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:azsoon/features/profile/data/profile_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'another_user_event.dart';
part 'another_user_state.dart';

class AnotherUserBloc extends Bloc<AnotherUserEvent, AnotherUserState> {
  AnotherUserBloc() : super(AnotherUserInitial()) {
    ProfileRepo profileRepo = ProfileRepo();
    on<AnotherUserLoad>((event, emit) async {
      emit(AnotherUserLoading());
      var response = await profileRepo.getProfile(event.userId);
      if (response.statusCode == 200) {
        Profile profile =
            Profile.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        emit(AnotherUserLoaded(profileModel: profile));
      } else {
        emit(AnotherUserError());
      }
    });
  }
}
