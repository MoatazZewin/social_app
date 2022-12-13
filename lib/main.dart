import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/layout/home_cubit/home_cubit.dart';
import 'package:social_simple_app/layout/home_cubit/home_states.dart';
import 'package:social_simple_app/layout/home_layout.dart';
import 'package:social_simple_app/modules/login/login_screen.dart';
import 'package:social_simple_app/shared/components/constants.dart';
import 'package:social_simple_app/shared/network/local/cache_helper.dart';
import 'package:social_simple_app/shared/network/remote/dio/dio_helper.dart';
import 'package:social_simple_app/shared/styles/themes.dart';

import 'bloc_observer.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  Widget startWidget;

  if (uId != null) {
    startWidget = const HomeScreen();
  } else {
    startWidget = LoginScreen();
  }

  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          startWidget is HomeScreen
              ? BlocProvider(
                  create: (context) => HomeCubit()
                    ..getUserData()
                    ..getPosts())
              : BlocProvider(create: (context) => HomeCubit()),
        ],
        child: BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                home: startWidget,
              );
            }));
  }
}
