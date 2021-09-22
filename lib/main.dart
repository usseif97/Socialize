import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/layout/home_layout.dart';
import 'package:socialize/modules/authentication/login_screen.dart';
import 'package:socialize/shared/bloc_observer.dart';
import 'package:socialize/shared/components/constants.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/theme_cubit.dart';
import 'package:socialize/shared/cubit/theme_states.dart';
import 'package:socialize/shared/network/local/cache_helper.dart';
import 'package:socialize/shared/styles/themes.dart';

void main() async {
  // Must be used if the main is async
  WidgetsFlutterBinding.ensureInitialized();

  // Intialize BlocObserver
  Bloc.observer = MyBlocObserver();

  // Intialize Firebase
  await Firebase.initializeApp();

  // Intialize Cache Helper
  await CacheHelper.init();

  // unique ID for the application used with Cloud Messaging
  var token = await FirebaseMessaging.instance.getToken();

  // Theme mode
  bool? isDark = CacheHelper.getData(key: 'isDark');

  // Start Screen
  Widget startWidget = LoginScreen();
  uID = CacheHelper.getData(key: 'uid');
  print('uID: $uID');
  if (uID != null) startWidget = HomeLayout();

  runApp(MyApp(isDark, startWidget));
}

class MyApp extends StatelessWidget {
  final isDark;
  final startWidget;
  MyApp(this.isDark, this.startWidget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // App Theme Provider
          create: (context) => ThemeCubit()..changeAppMode(cache: isDark),
        ),
        BlocProvider(
            create: (context) => HomeCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: BlocConsumer<ThemeCubit, ThemeStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return MaterialApp(
            title: 'Socialize',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
