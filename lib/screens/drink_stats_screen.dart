import 'package:flutter/material.dart';

class DrinkStatsScreen extends StatelessWidget {
  static const routeName = "/Drink-stats-screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 25.0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        titleSpacing: 5,
        title: Text(
          "Statistics",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[900],
                Colors.blue[300],
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0, 1],
            ),
          ),
        ),
      ),
    );
  }
}
