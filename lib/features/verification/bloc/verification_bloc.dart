import 'dart:convert';
import 'dart:io';

import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:azsoon/features/verification/data/verification_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationRepo repo = VerificationRepo();
  VerificationBloc() : super(VerificationInitial()) {
    on<VerificationEvent>((event, emit) async {});
    on<LoadProfileData>((event, emit) async {
      emit(VerificationLoading());
      var response = await repo.loadProfileData();
      print("load profile data");
      if (response.statusCode == 200) {
        var profile = Profile.fromJson(jsonDecode(response.body));
        emit(VerificationLoaded(profile: profile));
      }
    });
    on<UpdateProfileEvent>((event, emit) async {
      // emit(VerificationLoading());
      var response = await repo.updateProfile(
          firstName: event.firstName,
          lastName: event.lastName,
          speciality: event.speciality,
          cardId: event.cardId,
          selfie: event.selfie);
      if (response.statusCode == 200) {
        print(response.body + "ppsdfsdf");
        var profile = Profile.fromJson(jsonDecode(response.body));
        print(profile.cardId);

        emit((state as VerificationLoaded).copyWith(
            profile: Profile(
          cardId: profile.cardId,
          title: profile.title,
          bio: profile.bio,
          studyIn: profile.studyIn,
          cover: profile.cover,
          isme: profile.isme,
          profileImage: profile.profileImage,
          birthDate: profile.birthDate,
          placeOfWork: profile.placeOfWork,
          speciality: profile.speciality,
          user: profile.user,
        )));
      }
    });
  }
}
