import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.cyanAccent,
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      strokeWidth: 8.0,
    );
  }
}
