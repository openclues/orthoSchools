part of 'another_user_bloc.dart';

sealed class AnotherUserState extends Equatable {
  const AnotherUserState();

  @override
  List<Object> get props => [];
}

final class AnotherUserInitial extends AnotherUserState {}

class AnotherUserLoading extends AnotherUserState {}

class AnotherUserLoaded extends AnotherUserState {
  final Profile profileModel;

  const AnotherUserLoaded({required this.profileModel});
}


class AnotherUserError extends AnotherUserState{}