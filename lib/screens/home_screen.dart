import 'package:cup/screens/drink_stats_screen.dart';
import 'package:cup/screens/settings_screen.dart';
import 'package:cup/screens/tabs/home_tab.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  static const routeName = "/Home-screen";
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // int _currentIndex = 1;
  // final tabsList = [
  //   // drink
  //   DrinkTab(),
  //   // home
  //   HomeTab(),
  //   // walk
  //   WalkTab(),
  // ];

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onwillPop() {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ <= 2);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onwillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Drink Water",
            style: TextStyle(
              fontSize: 25.0,
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    SettingsScreen.routeName,
                  );
                },
              ),
            ),
          ],
        ),
        body: HomeTab(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            bottom: 20.0,
            right: 10.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(DrinkStatsScreen.routeName);
            },
            child: Container(
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
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
              child: Center(
                child: Icon(
                  Icons.bar_chart,
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   iconSize: 30.0,
        //   selectedItemColor: Colors.white,
        //   onTap: (index) {
        //     setState(() => _currentIndex = index);
        //   },
        //   currentIndex: _currentIndex,
        //   type: BottomNavigationBarType.shifting,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.local_drink),
        //       label: 'Drink',
        //       backgroundColor: Colors.green,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //       backgroundColor: Colors.blue,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.directions_walk),
        //       label: 'Walk',
        //       backgroundColor: Colors.red,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
