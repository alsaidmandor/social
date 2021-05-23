import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/bloc_observer.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:social/shared/network/local/cache_helper.dart';
import 'package:social/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/social_layout.dart';
import 'modules/login/login_sc.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());

  showToast(
    text: 'on background message',
    state: ToastStates.SUCCESS,
  );
}

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();

  print(token);

  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());

    showToast(
      text: 'on message',
      state: ToastStates.SUCCESS,
    );
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());

    showToast(
      text: 'on message opened app',
      state: ToastStates.SUCCESS,
    );
  });

  // // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}

// ./gradlew signingReport
