import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DrinkProvider extends ChangeNotifier {
  String id;
  int amount;
  String date;
  Timestamp timestamp;
  int todayTotalAmount = 0;
  // int _selectedDrinkAmount = 200;
  final String uid = FirebaseAuth.instance.currentUser.uid;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future setDrinkAmount() async {
    date = DateFormat.yMMMd().format(DateTime.now()) +
        " " +
        DateFormat.jm().format(DateTime.now());
    timestamp = Timestamp.now();
    todayTotalAmount += amount;
    db.collection("Goal").doc(uid).collection("Drink").doc().set({
      "Amount": amount,
      "dateTime": date.toString(),
      "timeStamp": timestamp,
    });
    createTodayTotalAmount();
    notifyListeners();
  }

  Future removeDrinkAmount(docId) async {
    await db
        .collection("Goal")
        .doc(uid)
        .collection("Drink")
        .doc(docId)
        .delete();
    createTodayTotalAmount();
  }

  Future createTodayTotalAmount() async {
    await db
        .collection("Goal")
        .doc(uid)
        .collection("TodayTotalAmount")
        .doc(uid)
        .set({
      "todayTotalAmount": todayTotalAmount.toString(),
    });
  }
}
