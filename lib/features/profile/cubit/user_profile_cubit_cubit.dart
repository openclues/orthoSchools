import 'dart:convert';

import 'package:azsoon/features/profile/data/profile_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/my_profile_model.dart';

part 'user_profile_cubit_state.dart';

class UserProfileCubitCubit extends Cubit<UserProfileCubitState> {
  UserProfileCubitCubit() : super(UserProfileCubitInitial());

  ProfileRepo profileRepo = ProfileRepo();

  loadUserProfile(int id) {
    emit(const UserProfileLoading());
    profileRepo.getProfile(id).then((value) {
      try {
        var profile =
            Profile.fromJson(jsonDecode(utf8.decode(value.bodyBytes)));
        emit(UserProfileLoaded(profileModel: profile));
      } catch (e) {
        emit(const UserProfileError(message: "Error"));
      }
    });
  }
}
