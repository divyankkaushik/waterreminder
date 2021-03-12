import 'package:cup/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextTheme textTheme = TextTheme();
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
                  auth.signInWithGoogle(context);
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
