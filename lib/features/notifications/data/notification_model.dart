import 'package:azsoon/main.dart';

import '../../space/presentation/space_screen.dart';

class NotificationModel {
  final String? title;
  final dynamic data;
  final bool? isRead;
  final String? trialing;
  final String? message;
  final Function? onTap;

  NotificationModel(
    this.title,
    this.data,
    this.isRead,
    this.message, {
    this.onTap,
    this.trialing,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'].containsValue('new_space')) {
      return NewSpaceNotificationModel.fromJson(json);
    }
    return NotificationModel(
      json['title'],
      json['data'],
      json['is_read'],
      json['message'],
    );
  }
}

class NewSpaceNotificationModel extends NotificationModel {
  // final String? cover;
  // final int? spaceId;

  NewSpaceNotificationModel(
    String? title,
    String? message,
    bool? isRead,
    String? cover,
    int? spaceId,
    dynamic data,
  ) : super(title, data, isRead, message, trialing: cover, onTap: () {
          // Navigator.pushNamed(context, SpaceScreen.routeName, arguments: spaceId);
          MyApp.navigatorKey.currentState!
              .pushNamed(SpaceScreen.routeName, arguments: spaceId);
        });

  factory NewSpaceNotificationModel.fromJson(Map<String, dynamic> json) {
    return NewSpaceNotificationModel(
      json['title'],
      json['message'],
      json['is_read'],
      json['data']['space_cover'],
      json['data']['spaceId'],
      json['data'],
    );
  }
}
