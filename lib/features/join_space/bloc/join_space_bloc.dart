import 'package:azsoon/features/join_space/data/join_space_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'join_space_event.dart';
part 'join_space_state.dart';

class JoinSpaceBloc extends Bloc<JoinSpaceEvent, JoinSpaceState> {
  JoinSpaceBloc() : super(JoinSpaceInitial()) {
    JoinSpaceRepo joinSpaceRepo = JoinSpaceRepo();
    on<JoinSpace>((event, emit) async {

      emit(JoinSpaceLoading(spaceId: event.spaceId));
      
      var response = await joinSpaceRepo.joinSpace(event.spaceId);
      if (response.statusCode == 200) {
        emit(JoinSpaceSuccess(
          spaceId: event.spaceId,
        ));
      } else {
        emit(JoinSpaceError(message: response.body));
      }
    });
  }
}
