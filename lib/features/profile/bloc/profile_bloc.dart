// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import 'package:azsoon/features/profile/data/profile_repo.dart';
import 'package:azsoon/features/verification/data/verification_repo.dart';

import '../data/my_profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepo profileRepo = ProfileRepo();
  VerificationRepo verificationRepo = VerificationRepo();
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});

    // on<LoadProfileData>((event, emit) async {
    //   emit(ProfileLoading());
    //   if (await RequestHelper.getAuthToken() == null) {
    //     emit(const ProfileIsNotSignedIn());
    //   } else {
    //     Response response;
    //     if (event.id == null) {
    //       response = await profileRepo.getMyProfile();
    //     } else {
    //       response = await profileRepo.getProfile(event.id.toString());
    //     }
    //     try {
    //       var profile =
    //           Profile.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    //       emit(ProfileLoaded(profileModel: profile));
    //     } catch (e) {}
    //   }
    // });
    // on<EditProfileEvent>((event, emit) async {
    //   var response = await verificationRepo.updateProfile(
    //     cardId: event.cardId,
    //     firstName: event.firstName,
    //     lastName: event.lastName,
    //   );
    //   try {
    //     var profile =
    //         Profile.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    //     emit(event.profileLoaded.copyWith(profileModel: profile));
    //   } catch (e) {}
    // });

    on<LoadMyProfile>((event, emit) async {
      //token
      // if (event.withputLoading) {
      // } else {
      emit(ProfileLoading());
      // }
      String? token = await RequestHelper.getAuthToken();
      if (token == null) {
        emit(const ProfileIsNotSignedIn());
      } else {
        var response = await profileRepo.getMyProfile();
        if (response.statusCode == 200) {
          var profile =
              Profile.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
          emit(ProfileLoaded(profileModel: profile));
        } else {
          emit(const ProfileIsNotSignedIn());
        }
        try {} catch (e) {
          emit(const ProfileIsNotSignedIn());
        }
      }
    });

    on<UpdateProfileLocally>((event, emit) {
      emit(event.profileLoaded.copyWith(
        profileModel: event.newProfile,
      ));
    });
  }
}
