import 'package:azsoon/Core/bloc_observer.dart';
import 'package:azsoon/Core/notifications/firebase_service.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/notifications/notifications_service.dart';
import 'package:azsoon/features/categories/bloc/categories_bloc.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/space/bloc/add_post_bloc.dart';
import 'package:azsoon/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Core/router.dart';
import 'features/blog/cubit/like_cubit_cubit.dart';
import 'features/home_screen/bloc/home_screen_bloc.dart';
import 'features/space/bloc/cubit/space_post_comments_cubit.dart';
import 'features/space/join_space/bloc/join_space_bloc.dart';

void main() async {
  // wait until all the widgets are loaded
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();

  // initialize firebase
  // ProfileBloc profileBloc = ProfileBloc();
  // profileBloc.add(const LoadMyProfile());
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await FirebaseService.initializeFirebase();
  // LocalNotification
  final RemoteMessage? message =
      await FirebaseService.firebaseMessaging.getInitialMessage();

  //register observers
  Bloc.observer = MyBlocObserver();
  // PushNotificationService pushNotificationService = PushNotificationService();
  // pushNotificationService.initialize(GlobalKey<NavigatorState>());

  // initialize the shared preferences
  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => PostsBloc()),
        BlocProvider(
          lazy: true,
          create: (context) => LoadingBlocBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => CategoriesBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => JoinSpaceBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => SpacePostCommentsCubit(),
        ),
        BlocProvider(
          // lazy: true,
          create: (context) => HomeScreenBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => AddPostBloc(),
        ),
        BlocProvider(lazy: true, create: (context) => LikeCubitCubit()),
      ],
      child: MyApp(
        message: message,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  RemoteMessage? message;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: 'Main Navigator');

  MyApp({super.key, this.message});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.message != null) {
        Future.delayed(const Duration(milliseconds: 1000), () async {
          await Navigator.of(
            MyApp.navigatorKey.currentContext!,
          ).push(
            MaterialPageRoute(
              builder: (context) => Container(
                color: Colors.white,
                child: const Center(
                  child: Text(
                    "Notification:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      title: 'OrthoSchool',
      debugShowCheckedModeBanner: debugDisableShadows,
      theme: ThemeData(fontFamily: 'Ubuntu'),
      //ThemeData(),
    );
  }
}
