import 'dart:convert';

import 'package:azsoon/features/notifications/data/notification_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/notification_model.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsRepo notificationsRepo = NotificationsRepo();
  NotificationsCubit() : super(NotificationsInitial());

  loadNotifications() async {
    emit(NotificationsLoading());
    var response = await notificationsRepo.getNotifications();
    if (response.statusCode == 200) {
      List<NotificationModel> notifications = [];
      for (var notification in jsonDecode(utf8.decode(response.bodyBytes))) {
        notifications.add(NotificationModel.fromJson(notification));
      }
      emit(NotificationsLoaded(notifications: notifications));
    } else {
      emit(const NotificationsError(message: 'Error loading notifications'));
    }
  }
  
}
