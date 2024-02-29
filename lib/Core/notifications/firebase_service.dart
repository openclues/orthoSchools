import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:azsoon/Core/notifications/models/notification_model.dart';
import 'package:azsoon/features/blog/bloc/cubit/single_comment_cubit.dart';
import 'package:azsoon/features/blog/data/models/articles_model.dart';
import 'package:azsoon/features/blog/presentation/screens/eachBlog.dart';
import 'package:azsoon/features/home_screen/data/models/latest_updated_posts_model.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:azsoon/features/space/presentation/comment_screen.dart';
import 'package:azsoon/features/space/presentation/post_screen.dart';
import 'package:azsoon/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../firebase_options.dart';
import '../network/request_helper.dart';
import 'fcm_provider.dart';

_getUpdatedPost(int? postId) async {
  var response = await RequestHelper.get('post/${postId!}');
  if (response.statusCode == 200) {
    return LatestUpdatedPost.fromJson(jsonDecode(response.body));
  }
}

void onDidReceiveLocalNotification(
    NotificationResponse? notificationResponse) async {
  // display a dialog with the notification details, tap ok to go to another page
  if (notificationResponse?.payload != null) {
    String v =
        notificationResponse!.payload!.replaceAll('payload', '"payload"');
    final responseJson = jsonDecode(v.replaceAll("'", '"'));

    PushNotificationModel notificationModel =
        PushNotificationModel.fromMap(responseJson);

    if (notificationModel.data!.containsValue('new_comments') ||
        notificationModel.data!.containsValue('new_like') ||
        notificationModel.data!.containsValue('new_reply')) {
      await _getUpdatedPost(int.parse(notificationModel.data!['postId']))
          .then((value) {
        MyApp.navigatorKey.currentState!
            .pushNamed(PostScreen.routeName, arguments: value);
      });
    } else if (notificationModel.data!.containsValue('blog_comment')) {
      //post
      ArticlesModel article =
          ArticlesModel.fromJson(jsonDecode(notificationModel.data!['post']));
      await MyApp.navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) => DetailPage(article: article)));
    }
  }
}

class FirebaseService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseService._firebaseMessaging = FirebaseMessaging.instance;
    await FirebaseService.initializeLocalNotifications();
    await FCMProvider.onMessage();
    await FirebaseService.onBackgroundMsg();
  }

  Future<String?> getDeviceToken() async =>
      await FirebaseMessaging.instance.getToken();

  static FlutterLocalNotificationsPlugin get localNotificationsPlugin =>
      FirebaseService._localNotificationsPlugin;

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeLocalNotifications() async {
    const InitializationSettings initSettings = InitializationSettings(
        android: AndroidInitializationSettings(
          "@mipmap/ic_launcher",
        ),
        iOS: DarwinInitializationSettings());

    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    /// on did receive notification response = for when app is opened via notification while in foreground on androidfnavi
    /// on select notification = for when app is opened via notification while in background on android
    /// on select notification = for when app is opened via notification while in background on ios
    /// on did receive local notification = for when app is opened via notification while in foreground on ios
    /// on did receive local notification = for when app is opened via notification while in background on ios
    ///
    ///
    await FirebaseService.localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onDidReceiveLocalNotification,
    );

    /// need this for ios foregournd notification
    await FirebaseService.firebaseMessaging
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static NotificationDetails platformChannelSpecifics =
      const NotificationDetails(
    android: AndroidNotificationDetails(
      "high_importance_channel",
      "High Importance Notifications",
      priority: Priority.max,
      importance: Importance.max,
    ),
  );

  // for receiving message when app is in background or foreground
  static Future<void> onMessage() async {
    try {
      ProfileState profileState =
          MyApp.navigatorKey.currentContext!.read<ProfileBloc>().state;

      MyApp.navigatorKey.currentContext!.read<ProfileBloc>().add(
          UpdateProfileLocally(
              profileLoaded: profileState as ProfileLoaded,
              newProfile: (profileState as ProfileLoaded).profileModel.copyWith(
                  notificationsCount: (profileState as ProfileLoaded)
                          .profileModel
                          .notificationsCount! +
                      1)));
    } catch (e) {
      print(e);
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        showAboutDialog(context: MyApp.navigatorKey.currentContext!);
        // if this is available when Platform.isIOS, you'll receive the notification twice
        await FirebaseService._localNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          FirebaseService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  static Future<void> onBackgroundMsg() async {
    FirebaseMessaging.onBackgroundMessage(FCMProvider.backgroundHandler);
  }
}
