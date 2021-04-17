import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cup/providers/auth.dart';
import 'package:cup/providers/goal_provider.dart';
import 'package:cup/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/Settings-screen";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _goalSetController = TextEditingController();
  final String uid = FirebaseAuth.instance.currentUser.uid;
  TextStyle listTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );

  Future<void> _showDialog() async {
    final goalauth = Provider.of<GoalProvider>(context, listen: false);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                Text(
                  "Set Your Goal",
                  style: TextStyle(fontSize: 20.0),
                ),
                TextField(
                  controller: _goalSetController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Remind every some hour",
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                goalauth.goal = _goalSetController.text;
                goalauth.createGoal();
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
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
          "Settings",
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
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Goal')
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) return CircularProgressIndicator();
            return Column(
              children: [
                ListTile(
                  title: Text(
                    "Goal",
                    style: listTextStyle,
                  ),
                  trailing: Text(
                    (snapshot.data.exists) ? snapshot.data["goal"] : "0",
                    style: listTextStyle,
                  ),
                ),
                Divider(
                  color: Colors.black38,
                ),
                ListTile(
                  title: Text(
                    "Remind Every",
                    style: listTextStyle,
                  ),
                  trailing: Text(
                    "2  hour",
                    style: listTextStyle,
                  ),
                ),
                Divider(
                  color: Colors.black38,
                ),
                ListTile(
                  title: Text(
                    "Share App",
                    style: listTextStyle,
                  ),
                  trailing: Icon(
                    Icons.share,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  onTap: () {
                    Share.share(
                        "https://vaya.in/recipes/wp-content/uploads/2018/02/Milk-Chocolate-1.jpg");
                  },
                ),
                Divider(
                  color: Colors.black38,
                ),
                ListTile(
                  title: Text(
                    "Sign Out",
                    style: listTextStyle,
                  ),
                  trailing: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  onTap: () {
                    auth.signOut();
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                ),
                Divider(
                  color: Colors.black38,
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        child: Icon(Icons.edit),
      ),
    );
  }
}
