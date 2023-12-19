part of 'activities_bloc.dart';

sealed class ActivitiesState extends Equatable {
  const ActivitiesState();
  
  @override
  List<Object> get props => [];
}

final class ActivitiesInitial extends ActivitiesState {}



class ActivitesLoading extends ActivitiesState {
  const ActivitesLoading();
  @override
  List<Object> get props => [];
}

class ActivitiesLoaded extends ActivitiesState {
  final List<Activity> activities;
  const ActivitiesLoaded({required this.activities});
  @override
  List<Object> get props => [activities];
}


class ActivitiesError extends ActivitiesState {
  final String message;
  const ActivitiesError({required this.message});
  @override
  List<Object> get props => [message];
}