import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/on_boarding/on_boarding_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cash_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:social_app/social_layout/social_layout.dart';
import 'package:social_app/social_login_screen/social_login_screen.dart';



Future<void> _backgroundMessageHandler(RemoteMessage message) async
{
  print('background message');
  Fluttertoast.showToast(
    msg: 'background message',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');

  token =await FirebaseMessaging.instance.getToken().toString();
  print(token);
  print('xxxxxxxxxxxxxxxxxxxxxxx');
//foreGround fcm
  FirebaseMessaging.onMessage
      .listen((event) {
    print('success');
    Fluttertoast.showToast(
      msg: 'onMessage',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  })
      .onError((error) {
    print('error');
  });
//when click notification to open foreGround fcm

  FirebaseMessaging.onMessageOpenedApp
      .listen((event) {
    print('success');
    Fluttertoast.showToast(
      msg: 'onMessageOpenedApp',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  })
      .onError((error) {
    print('error');
  });
//backGround fcm

  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

  //token = CacheHelper.getData(key: 'token');
  //print(onBoarding);
  if (onBoarding != null) {
    if (uId != null) {
      print(uId);
      widget = SocialLayout();
    } else {
      widget = SocialLoginScreen();
    }
  } else {
    widget = On_boarding_Screen();
  }


  runApp(MyApp(
    onBoarding: onBoarding, startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool onBoarding;
  final Widget startWidget;

  const MyApp({this.onBoarding, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
            SocialCubit()
              ..getUserData()
              ..getUsers()
              ..getPosts()

        ),

      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter',
          theme: lightTheme,
          home: startWidget
      ),
    );
  }
}


