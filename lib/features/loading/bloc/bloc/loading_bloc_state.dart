part of 'loading_bloc_bloc.dart';

sealed class LoadingBlocState extends Equatable {
  const LoadingBlocState();

  @override
  List<Object> get props => [];
}

final class LoadingBlocInitial extends LoadingBlocState {}

class UserIsSignedIn extends LoadingBlocState {
  final Profile profile;
  const UserIsSignedIn({
    required this.profile,
  });
}

class UserIsNotSignedIn extends LoadingBlocState {
  const UserIsNotSignedIn();
}


class LoadingLoading extends LoadingBlocState {
  const LoadingLoading();
}