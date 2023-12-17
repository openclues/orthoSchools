import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/home_screen_model.dart';
import '../../data/respos/home_screen_repo.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    HomeScreenRepo homeScreenRepo = HomeScreenRepo();
    on<HomeScreenEvent>((event, emit) {});
    on<ReasetHomeScreenData>((event, emit) {
      emit(HomeScreenInitial());
    });
    on<LoadHomeScreenData>((event, emit) async {
      // emit(HomeScreenLoading());

      try {
        var response = await homeScreenRepo.getHomeScreenData();

        if (response.statusCode == 200) {
          var decodedResponse = jsonDecode(response.body);
          var homeScreenModel = HomeScreenModel.fromJson(decodedResponse);
          emit(HomeScreenLoaded(homeScreenModel: homeScreenModel));
        } else if (response.statusCode == 401) {
          emit(const HomeScreenNotAuthenticated(
              message: 'Your session has expired'));
        } else if (response.statusCode == 403 || response.statusCode == 401) {
          emit(const HomeScreenNotAuthenticated(
              message: 'Your session has expired'));
        } else {
          emit(const HomeScreenError(message: 'Something went wrong'));
        }
      } catch (e) {
        emit(const HomeScreenError(message: 'Something went wrong'));
      }
    });
  }
}
