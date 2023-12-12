part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenLoaded extends HomeScreenState {
  final HomeScreenModel homeScreenModel;
  const HomeScreenLoaded({required this.homeScreenModel});

  @override
  List<Object> get props => [homeScreenModel];
}

class HomeScreenError extends HomeScreenState {
  final String message;
  const HomeScreenError({required this.message});
}

class HomeScreenNotAuthenticated extends HomeScreenState {
  final String message;
  const HomeScreenNotAuthenticated({required this.message});
}
