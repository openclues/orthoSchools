import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_bloc_event.dart';
part 'loading_bloc_state.dart';

class LoadingBlocBloc extends Bloc<LoadingBlocEvent, LoadingBlocState> {
  LocalStorage localStorage = LocalStorage();
  LoadingBlocBloc() : super(LoadingBlocInitial()) {
    on<LoadingBlocEvent>((event, emit) {});

    on<CheckUserStatus>((event, emit) async {
      if (LocalStorage.getString('authToken') != null ||
          await RequestHelper.getAuthToken() != null) {
        emit(const UserIsSignedIn());
      } else {
        emit(const UserIsNotSignedIn());
      }
    });
  }
}
