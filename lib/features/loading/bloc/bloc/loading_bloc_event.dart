part of 'loading_bloc_bloc.dart';

sealed class LoadingBlocEvent extends Equatable {
  const LoadingBlocEvent();

  @override
  List<Object> get props => [];
}


class CheckUserStatus extends LoadingBlocEvent {
  const CheckUserStatus();
}


