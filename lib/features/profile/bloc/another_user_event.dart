part of 'another_user_bloc.dart';

sealed class AnotherUserEvent extends Equatable {
  const AnotherUserEvent();

  @override
  List<Object> get props => [];
}

class AnotherUserLoad extends AnotherUserEvent {
  final int userId;
  const AnotherUserLoad({required this.userId});
}
