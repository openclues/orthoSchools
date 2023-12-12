import 'dart:convert';

import 'package:azsoon/features/profile/data/profile_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/my_profile_model.dart';
import '../data/user_profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepo profileRepo = ProfileRepo();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<LoadProfileData>((event, emit) async {
      var response = await profileRepo.getProfile(event.id.toString());
      try {
        var profile = Profile.fromJson(jsonDecode(response.body));
        emit(ProfileLoaded(profileModel: profile));
      } catch (e) {
        print(e.toString());
        // var profile = Profile.fromJson(jsonDecode(response.body));
        // emit(ProfileLoaded(profileModel: profile));
      }
    });
  }
}
