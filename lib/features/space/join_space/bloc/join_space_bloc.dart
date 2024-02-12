import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../home_screen/data/models/latest_updated_posts_model.dart';
import '../data/join_space_repo.dart';

part 'join_space_event.dart';
part 'join_space_state.dart';

class JoinSpaceBloc extends Bloc<JoinSpaceEvent, JoinSpaceState> {
  JoinSpaceBloc() : super(JoinSpaceInitial()) {
    JoinSpaceRepo joinSpaceRepo = JoinSpaceRepo();
    on<JoinSpace>((event, emit) async {
      emit(JoinSpaceLoading(spaceId: event.spaceId));

      var response = await joinSpaceRepo.joinSpace(event.spaceId);
      if (response.statusCode == 200) {
        SimpleSpace space =
            SimpleSpace.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        emit(JoinSpaceSuccess(
          space: space,
          spaceId: event.spaceId,
        ));
      } else {
        emit(JoinSpaceError(message: response.body));
      }
    });
  }
}
