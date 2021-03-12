import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cup/screens/settings_screen.dart';
import 'package:cup/screens/tabs/drink_tab.dart';
import 'package:cup/screens/tabs/home_tab.dart';
import 'package:cup/screens/tabs/walk_tab.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  static const routeName = "/Home-screen";
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentIndex = 1;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final tabsList = [
    // drink
    DrinkTab(),
    // home
    HomeTab(),
    // walk
    WalkTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Drink Water",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(155, 117, 255, 1).withOpacity(0.5),
                Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
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
                size: 35.0,
              ),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => SettingsScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: tabsList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30.0,
        selectedItemColor: Colors.white,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Drink',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            label: 'Walk',
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
