import 'package:cup/providers/auth.dart';
import 'package:cup/screens/create_goal_screen.dart';
import 'package:cup/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    getCounterValue();
  }

  void getCounterValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (this.mounted) {
    setState(() {
      counter = prefs.getInt(
            "goalScreen",
          ) ??
          0;
    });}
    print(counter);
  }

  void goToCreateGoalScreen() async {
    setState(() {
      counter++;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("goalScreen", counter);
    });
    if (counter == 1) {
      Navigator.of(context).pushNamed(CreateGoalScreen.routeName);
    } else {
      Navigator.of(context).pushNamed(Homescreen.routeName);
    }
    print(counter);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 100, width: double.infinity),
            Image.asset(
              'assets/images/heart.png',
              width: 200,
              height: 200,
            ),
            Text(
              "We help you stay fit",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            ButtonTheme(
              minWidth: 224,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  auth.signInWithGoogle(context, goToCreateGoalScreen);
                },
                child: Text('Google Sign in'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
