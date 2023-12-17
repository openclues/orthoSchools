import 'dart:convert';

import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/loading/presentation/data/loading_repo.dart';
import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_bloc_event.dart';
part 'loading_bloc_state.dart';

class LoadingBlocBloc extends Bloc<LoadingBlocEvent, LoadingBlocState> {
  LocalStorage localStorage = LocalStorage();
  LoadingRepo loadingRepo = LoadingRepo();

  LoadingBlocBloc() : super(LoadingBlocInitial()) {
    on<LoadingBlocEvent>((event, emit) {});

    on<CheckUserStatus>((event, emit) async {
      if (LocalStorage.getString('authToken') == null ||
          await RequestHelper.getAuthToken() == null) {
        emit(const UserIsNotSignedIn());
      } else {
        var response = await loadingRepo.getMyProfile();
        if (response.statusCode == 200) {
          Profile profile = Profile.fromJson(jsonDecode(response.body));
          emit(UserIsSignedIn(
            profile: profile,
          ));
        } else {
          emit(const UserIsNotSignedIn());
        }
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(const LoadingLoading());
      emit(UserIsSignedIn(profile: event.profile));
    });
  }
}
