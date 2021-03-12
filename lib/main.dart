import 'package:cup/providers/drink_provider.dart';
import 'package:cup/providers/goal_provider.dart';
import 'package:cup/screens/create_goal_screen.dart';
import 'package:cup/screens/home_screen.dart';
import 'package:cup/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cup/providers/auth.dart';
import 'package:cup/root_page.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future selectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Dili"));
  await Hive.initFlutter();
  await Hive.openBox<int>('steps');

// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  final MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);

  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Drink Water Reminder',
      'Time to drink water',
      tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1)),
      const NotificationDetails(
          android: AndroidNotificationDetails(
        'your channel id',
        'Drink Water Reminder',
        'Time to drink water',
      )),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => GoalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DrinkProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.blue,
    // ));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          Homescreen.routeName: (context) => Homescreen(),
          CreateGoalScreen.routeName: (context) => CreateGoalScreen(),
        },
      ),
    );
  }
}
