import 'dart:convert';

import 'package:azsoon/features/profile/data/activity_model.dart';
import 'package:azsoon/features/profile/data/profile_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  final ProfileRepo activitiesRepo = ProfileRepo();
  ActivitiesBloc() : super(ActivitiesInitial()) {
    on<ActivitiesEvent>((event, emit) {});
    on<LoadActvites>((event, emit) async {
      var response = await activitiesRepo.getMyActivity();
      if (response.statusCode == 200) {
        List<Activity> activities = [];
        for (var item in jsonDecode(utf8.decode(response.bodyBytes))) {
          activities.add(Activity.fromJson(item));
        }
        emit(ActivitiesLoaded(activities: activities));
      } else {
        emit(const ActivitiesError(message: 'Error loading activities'));
      }
    });
  }
}
