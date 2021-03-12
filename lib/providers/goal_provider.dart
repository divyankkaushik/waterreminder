import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class GoalProvider extends ChangeNotifier {
  String goal = "0";
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future createGoal() async {
    final uid = auth.currentUser.uid;
    String date = DateFormat.yMMMd().format(DateTime.now()) +
        " " +
        DateFormat.jm().format(DateTime.now());
    await db.collection("Goal").doc(uid).set({
      "goal": goal,
      "dateTime": date.toString(),
    });
    notifyListeners();
  }

  Future loadGoal() async {
    // final uid = auth.currentUser.uid;
    try {
      var queryDocuments = await db.collection("Goal").get();
      if (queryDocuments.docs.isNotEmpty) {
        return queryDocuments.docs.map((snapshot) {
          print(snapshot.data());
        }).toList();
      }
    } catch (e) {
      print(e);
    }
  }
}
