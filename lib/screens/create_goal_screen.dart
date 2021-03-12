import 'package:cup/providers/goal_provider.dart';
import 'package:cup/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateGoalScreen extends StatelessWidget {
  static const routeName = "/create-goal-screen";

  final TextEditingController _goalSetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final goalauth = Provider.of<GoalProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Create Your goal",
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            autofocus: true,
            controller: _goalSetController,
            maxLength: 4,
            decoration: InputDecoration(hintText: "Create Goal"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          goalauth.goal = _goalSetController.text;
          goalauth.createGoal();
          Navigator.of(context).pushNamed(Homescreen.routeName);
        },
        label: Text("Save"),
      ),
    );
  }
}
