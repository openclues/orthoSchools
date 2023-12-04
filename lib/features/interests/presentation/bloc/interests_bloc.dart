import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'interests_event.dart';
part 'interests_state.dart';

class InterestsBloc extends Bloc<InterestsEvent, InterestsState> {
  InterestsBloc() : super(InterestsInitial()) {
    on<InterestsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
