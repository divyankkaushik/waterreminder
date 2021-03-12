import 'package:flutter/material.dart';

class DrinkTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Text("drink tab"),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text("Hello"),
        ),
      ],
    );
  }
}
