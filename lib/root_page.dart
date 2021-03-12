import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cup/providers/auth.dart';
import 'package:cup/screens/home_screen.dart';
import 'package:cup/screens/login_screen.dart';

/// This RootPage will display the home page
/// or the login page depending if we are
/// authenticated
class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    // final notificationBloc = Provider.of<AppBloc>(context).notificationBloc;
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Homescreen();
        }
        // notificationBloc.cancelNotifications();
        return LoginScreen();
      },
    );
  }
}