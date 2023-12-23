import 'package:azsoon/Core/bloc_observer.dart';
import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Providers/DrawerNavProvider.dart';
import 'package:azsoon/Providers/moreUserInfoProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import './Providers/userInfoProvider.dart';
import 'Core/router.dart';

void main() async {
  // wait until all the widgets are loaded
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();

  //register observers
  Bloc.observer = MyBlocObserver();
  // initialize the shared preferences
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => MoreInfoUserProvider()),
        // ChangeNotifierProvider(create: (context) => DrawerProvider()),
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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: debugDisableShadows,
      theme: ThemeData(fontFamily: 'Ubuntu'),
      //ThemeData(),
    );
  }
}
