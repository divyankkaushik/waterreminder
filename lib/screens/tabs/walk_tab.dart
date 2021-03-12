import 'package:flutter/material.dart';

class WalkTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Text("Walk Tab"),
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
