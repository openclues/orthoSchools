import 'dart:io';

import 'package:azsoon/Core/notifications/firebase_service.dart';
import 'package:azsoon/main.dart';
import 'package:azsoon/screens/ProfilePage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../features/profile/bloc/profile_bloc.dart';

class FCMProvider with ChangeNotifier {
  static BuildContext? _context;
  static Function(bool)? _refreshNotifications;

  static void setContext(BuildContext context) {
    _context = context;
  }

  /// when app is in the foreground
  static Future<void> onTapNotification(NotificationResponse? response) async {
    if (FCMProvider._context == null || response?.payload == null) return;
    // if (FCMProvider._context == null || response?.payload == null) return;
    // final Map _data = FCMProvider.convertPayload(response!.payload!);
    // if (_data.containsKey("")) {
    await MyApp.navigatorKey.currentState!.pushNamed(ProfilePage.routeName);
    // }
  }

  static Map<String, dynamic> convertPayload(String payload) {
    final String _payload = payload.substring(1, payload.length - 1);
    List<String> _split = [];
    _payload.split(",").forEach((String s) => _split.addAll(s.split(":")));
    Map<String, dynamic> mapped = {};
    for (int i = 0; i < _split.length + 1; i++) {
      if (i % 2 == 1)
        mapped.addAll({_split[i - 1].trim().toString(): _split[i].trim()});
    }
    return mapped;
  }

  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final ProfileState profileState =
          MyApp.navigatorKey.currentContext!.read<ProfileBloc>().state;
      MyApp.navigatorKey.currentContext!.read<ProfileBloc>().add(
          UpdateProfileLocally(
              profileLoaded: profileState as ProfileLoaded,
              newProfile: (profileState).profileModel.copyWith(
                  notificationsCount: (profileState as ProfileLoaded)
                          .profileModel
                          .notificationsCount! +
                      1)));

      if (FCMProvider._refreshNotifications != null) {
        await FCMProvider._refreshNotifications!(true);
      }

      // if this is available when Platform.isIOS, you'll receive the notification twice
      if (Platform.isAndroid) {
        await FirebaseService.localNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          FirebaseService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    if (FCMProvider._refreshNotifications != null) {
      await FCMProvider._refreshNotifications!(true);
    }
    if (Platform.isAndroid) {
      await FirebaseService.localNotificationsPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        FirebaseService.platformChannelSpecifics,
        payload: message.data.toString(),
      );
    }
  }
}
