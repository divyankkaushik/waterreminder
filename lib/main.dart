import 'package:cup/plugin/notification_plugin.dart';
import 'package:cup/providers/drink_provider.dart';
import 'package:cup/providers/goal_provider.dart';
import 'package:cup/screens/create_goal_screen.dart';
import 'package:cup/screens/drink_stats_screen.dart';
import 'package:cup/screens/home_screen.dart';
import 'package:cup/screens/login_screen.dart';
import 'package:cup/screens/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cup/providers/auth.dart';
import 'package:cup/root_page.dart';
import 'package:workmanager/workmanager.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notifLaunch;

void callbackDispatcher() {
  int hour = DateTime.now().hour;
  if (hour >= 8 && hour <= 22) {
    Workmanager.executeTask((task, inputData) {
      showNotificationPeriodically(
        flutterLocalNotificationsPlugin,
        "0",
        "Drink Water",
      );
      return Future.value(true);
    });
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox<int>('steps');

  Workmanager.initialize(callbackDispatcher);
  Workmanager.registerPeriodicTask(
    "sendnotification",
    "atask",
    frequency: Duration(hours: 1),
  );
  notifLaunch =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  initNotificatioin(flutterLocalNotificationsPlugin);

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

// int blackPrimaryValue = 0xFF000000;
// Map<int, Color> color = {
//   50: Color(0xFF000000),
//   100: Color(0xFF000000),
//   200: Color(0xFF000000),
//   300: Color(0xFF000000),
//   400: Color(0xFF000000),
//   500: Color(0xFF000000),
//   600: Color(0xFF000000),
//   700: Color(0xFF000000),
//   800: Color(0xFF000000),
//   900: Color(0xFF000000),
// };

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
          SettingsScreen.routeName: (context) => SettingsScreen(),
          DrinkStatsScreen.routeName: (context) => DrinkStatsScreen(),
        },
      ),
    );
  }
}
