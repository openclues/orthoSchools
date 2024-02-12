part of 'notifications_cubit.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}


final class NotificationsLoading extends NotificationsState {}


final class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;
  const NotificationsLoaded({required this.notifications});
  @override
  List<Object> get props => [notifications];
}


final class NotificationsError extends NotificationsState {
  final String message;
  const NotificationsError({required this.message});
  @override
  List<Object> get props => [message];
}