import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  PushNotificationService();

  static showProgressNotification() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      // 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      0,
      'Uploading...',
      'Please wait while we upload your post',
      platformChannelSpecifics,
      payload:
          'ProfileScreen', // Use payload to navigate when the notification is clicked
    );
  }

  Future<void> initialize(GlobalKey<NavigatorState> navigatorKey) async {
    // Request permission for handling notifications (if needed)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle different permission scenarios
    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        // Permission granted
        break;
      case AuthorizationStatus.provisional:
        // Provisional permission granted (iOS 15+)
        break;
      case AuthorizationStatus.denied:
        // Permission denied
        break;
      case AuthorizationStatus.notDetermined:
        // Permission not determined
        break;
    }

    // Initialize Flutter Local Notifications
    await initializeLocalNotifications();

    // Handle incoming messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        // 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        platformChannelSpecifics,
        payload:
            'ProfileScreen', // Use payload to navigate when the notification is clicked
      );
    });

    // Handle notification clicks when the app is in the background or terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigateToScreen(navigatorKey, 'ProfileScreen');
    });

    // Configure the background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Background message handler function
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Handle background messages if needed
  }

  // Helper function to navigate to a specific screen
  void navigateToScreen(
      GlobalKey<NavigatorState> navigatorKey, String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  // Initialize Flutter Local Notifications
  Future<void> initializeLocalNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Android-specific configuration
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');

    // iOS-specific configuration
    // const D iosInitializationSettings =
    //     IOSInitializationSettings();

    // Initialization settings for both platforms
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      // iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {},
    );
  }
}
