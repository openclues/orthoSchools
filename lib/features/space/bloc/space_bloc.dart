import 'dart:convert';

import 'package:azsoon/features/space/data/space_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../home_screen/data/models/recommended_spaces_model.dart';

part 'space_event.dart';
part 'space_state.dart';

class SpaceBloc extends Bloc<SpaceEvent, SpaceState> {
  SpaceRepo spaceRepo = SpaceRepo();
  SpaceBloc() : super(SpaceInitial()) {
    on<SpaceEvent>((event, emit) {});
    on<LoadSpace>((event, emit) async {
      var response = await spaceRepo.getSpace(event.id.toString());
      if (response.statusCode == 200) {
        RecommendedSpace space = RecommendedSpace.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
        emit(SpaceLoaded(
          space,
        ));
      }
    });
  }
}
