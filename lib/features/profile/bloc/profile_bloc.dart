import 'dart:convert';

import 'package:azsoon/features/profile/data/profile_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/src/response.dart';

import '../data/my_profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepo profileRepo = ProfileRepo();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<LoadProfileData>((event, emit) async {
      Response response;
      if (event.id == null) {
        response = await profileRepo.getMyProfile();
      } else {
        response = await profileRepo.getProfile(event.id.toString());
      }
      try {
        var profile = Profile.fromJson(jsonDecode(response.body));
        emit(ProfileLoaded(profileModel: profile));
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
