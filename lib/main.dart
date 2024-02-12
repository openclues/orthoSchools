import 'package:azsoon/Core/bloc_observer.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/notifications_service.dart';
import 'package:azsoon/features/categories/bloc/categories_bloc.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/space/bloc/add_post_bloc.dart';
import 'package:azsoon/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  //register observers
  Bloc.observer = MyBlocObserver();
  PushNotificationService pushNotificationService = PushNotificationService();
  pushNotificationService.initialize(GlobalKey<NavigatorState>());

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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouter.generateRoute,
      title: 'OrthoSchool',
      debugShowCheckedModeBanner: debugDisableShadows,
      theme: ThemeData(fontFamily: 'Ubuntu'),
      //ThemeData(),
    );
  }
}
