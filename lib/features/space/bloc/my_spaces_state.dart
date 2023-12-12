part of 'my_spaces_bloc.dart';

sealed class MySpacesState extends Equatable {
  const MySpacesState();
  
  @override
  List<Object> get props => [];
}

final class MySpacesInitial extends MySpacesState {}



class MySpacesLoaded extends MySpacesState {
  final List<Space> spaces;
  const MySpacesLoaded({required this.spaces});
  @override
  List<Object> get props => [spaces];
}

class MySpacesError extends MySpacesState {
  final String message;
  const MySpacesError({required this.message});
  @override
  List<Object> get props => [message];
}


class MySpacesLoading extends MySpacesState {
  const MySpacesLoading();
  @override
  List<Object> get props => [];
}