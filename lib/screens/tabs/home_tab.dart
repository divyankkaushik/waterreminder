import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cup/providers/drink_provider.dart';
import 'package:cup/widgets/loadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String uid = FirebaseAuth.instance.currentUser.uid;
  TextStyle goalTextStyle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.w600,
  );
  TextStyle amountTextStyle = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
  );
  TextStyle listTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );

  Future getAmountList() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot reference = await firestore
        .collection("Goal")
        .doc(uid)
        .collection("Drink")
        .orderBy(
          "timeStamp",
          descending: true,
        )
        .get();
    return reference.docs;
  }

  @override
  Widget build(BuildContext context) {
    final drinkProvider = Provider.of<DrinkProvider>(context);
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Text(
                  "GOAL",
                  style: goalTextStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Goal')
                            .doc(uid)
                            .collection("TodayTotalAmount")
                            .doc(uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return LoadingWidget();
                          } else {
                            return Text(
                              (snapshot.data.exists)
                                  ? "${snapshot.data["todayTotalAmount"]}"
                                  : "0",
                              style: goalTextStyle,
                            );
                          }
                        }),
                    Text(
                      "  /  ",
                      style: goalTextStyle,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Goal')
                            .doc(uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null)
                            return LoadingWidget();
                          return Text(
                            (snapshot.data.exists)
                                ? snapshot.data["goal"]
                                : "0",
                            style: goalTextStyle,
                          );
                        }),
                    Text(
                      "  ml",
                      style: goalTextStyle,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          drinkProvider.amount = 100;
                          drinkProvider.setDrinkAmount();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/100ml.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "100 ml",
                              style: amountTextStyle,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          drinkProvider.amount = 200;
                          drinkProvider.setDrinkAmount();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/200ml.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "200 ml",
                              style: amountTextStyle,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          drinkProvider.amount = 300;
                          drinkProvider.setDrinkAmount();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/300ml.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "300 ml",
                              style: amountTextStyle,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          drinkProvider.amount = 400;
                          drinkProvider.setDrinkAmount();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/400ml.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "400 ml",
                              style: amountTextStyle,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          drinkProvider.amount = 500;
                          drinkProvider.setDrinkAmount();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/500ml.png',
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "500 ml",
                              style: amountTextStyle,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        FutureBuilder(
            future: getAmountList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: LoadingWidget(),
                ));
              } else {
                return Expanded(
                  key: UniqueKey(),
                  flex: 4,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Theme.of(context).primaryColor,
                        ),
                        // Can implement undo feature
                        onDismissed: (direction) {
                          setState(() {
                            drinkProvider
                                .removeDrinkAmount(snapshot.data[index].id);
                            drinkProvider.todayTotalAmount -=
                                snapshot.data[index].data()["Amount"];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  (snapshot.data[index].data()["Amount"])
                                      .toString(),
                                  style: listTextStyle,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "ml",
                                  style: listTextStyle,
                                ),
                              ],
                            ),
                            subtitle: Text(
                              snapshot.data[index].data()["dateTime"],
                              style: listTextStyle,
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).primaryColor,
                                size: 30.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  drinkProvider.removeDrinkAmount(
                                      snapshot.data[index].id);
                                  drinkProvider.todayTotalAmount -=
                                      snapshot.data[index].data()["Amount"];
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            })
      ],
    );
  }
}
