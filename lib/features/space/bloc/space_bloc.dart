import 'dart:convert';

import 'package:azsoon/features/space/data/space_model.dart';
import 'package:azsoon/features/space/data/space_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'space_event.dart';
part 'space_state.dart';

class SpaceBloc extends Bloc<SpaceEvent, SpaceState> {
  SpaceRepo spaceRepo = SpaceRepo();
  SpaceBloc() : super(SpaceInitial()) {
    on<SpaceEvent>((event, emit) {});
    on<LoadSpace>((event, emit) async {
      var response = await spaceRepo.getSpace(event.id.toString());
      if (response.statusCode == 200) {
        Space space = Space.fromJson(jsonDecode(response.body));
        emit(SpaceLoaded(
          space,
        ));
      }
    });
  }
}
