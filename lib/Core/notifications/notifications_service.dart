import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  BuildContext? context;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // Create a singleton class
  PushNotificationService._privateConstructor();
  static final PushNotificationService _instance =
      PushNotificationService._privateConstructor();
  factory PushNotificationService() {
    return _instance;
  }

  static setContext(BuildContext context) {
    _instance.context = context;
  }

  static showProgressNotification() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
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

  //hide progress notification
  static hideProgressNotification() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.cancel(0);
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
      handleNotification(message, navigatorKey);
    });

    // Handle notification clicks when the app is in the background or terminated state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotification(message, navigatorKey);
    });

    // Configure the background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Background message handler function
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // Handle background messages if needed
    handleNotification(message, navigatorKey);
  }

  // Helper function to navigate to a specific screen
  void navigateToScreen(
      GlobalKey<NavigatorState> navigatorKey, String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  // Handle notification based on app state
  void handleNotification(
      RemoteMessage message, GlobalKey<NavigatorState> navigatorKey) {
    if (message.notification != null) {
      // If notification is received while app is in the foreground
      if (message.notification!.title != null &&
          message.notification!.body != null) {
        _showNotification(message.notification!, navigatorKey);
      }
    }
  }

  // Display local notification
  void _showNotification(
      RemoteNotification notification, GlobalKey<NavigatorState> navigatorKey) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    flutterLocalNotificationsPlugin.show(
      0,
      notification.title ?? '',
      notification.body ?? '',
      platformChannelSpecifics,
      payload: notification.body,
    );

    // Navigate to specific screen when notification is clicked
    // if (notification. != null) {
    navigateToScreen(navigatorKey, 'ProfileScreen');
  }
}

// Initialize Flutter Local Notifications
Future<void> initializeLocalNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Android-specific configuration
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('ic_launcher');

  // iOS-specific configuration
  // const IOSInitializationSettings iosInitializationSettings =
  //     IOSInitializationSettings();

  // Initialization settings for both platforms
  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    // iOS: iosInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse: (details) {},
  );
}
