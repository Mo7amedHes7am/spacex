import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spacex/Design/Colors/ColorsMethods.dart';
import 'package:spacex/Design/Splash/SplashScreen.dart';
import 'package:spacex/NewDesign/NewSplash/NewSplash.dart';
import 'package:spacex/firebase_options.dart';

late SharedPreferences prefs ;

displaynotifications(){
  AwesomeNotifications().initialize(
      'resource://mipmap/ic_launcher_foreground',
      [
        NotificationChannel(
            icon: 'resource://mipmap/ic_launcher_foreground',
            channelGroupKey: 'stormx_channel_group',
            channelKey: 'stormx_channel',
            channelName: 'stormx notifications',
            channelDescription: 'Notification channel for stormx',
            defaultColor: primary,
            playSound: true,
            channelShowBadge: true,
            ledColor: primary)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'stormx_channel_group',
            channelGroupName: 'stormx group')
      ],
      debug: true
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  displaynotifications();
  AwesomeNotifications().requestPermissionToSendNotifications();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: "stormx_channel",
        title: message.notification!.title,
        body: message.notification!.body,
        icon: 'resource://mipmap/ic_launcher_foreground',
        notificationLayout: NotificationLayout.BigPicture,
        wakeUpScreen: true,
      ),
    );
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

int i =0;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getToken()async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    String? myToken = await FirebaseMessaging.instance.getToken();
    print("=====================================================>$myToken");
  }

  @override
  void initState() {
    // print(FirebaseAuth.instance.currentUser!.uid);
    getToken();
    displaynotifications();
    if (FirebaseAuth.instance.currentUser == null) {
      FirebaseMessaging.instance.deleteToken();
    }
    else{
      FirebaseMessaging.instance.subscribeToTopic("news");
    }
    AwesomeNotifications().requestPermissionToSendNotifications();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("======================");
        print(message.notification!.title);
        print(message.notification!.body);
        print("======================");

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: i,
            icon: 'resource://mipmap/ic_launcher_foreground',
            channelKey: "stormx_channel",
            title: message.notification!.title,
            body: message.notification!.body,
            notificationLayout: NotificationLayout.BigPicture,
            wakeUpScreen: true,
          ),
        );

        i++;

      }
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]
    );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primary,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ));

    return ScreenUtilInit(
      designSize: Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SafeArea(child: NewSplashScreen()),
        );
      },
    );
  }
}
