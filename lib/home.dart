import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home2(),
    );
  }
}

class Home2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState1();
  }
}

class _HomeState1 extends State<Home2> {
  String Y = "User";

  var firebaseUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  final myController = TextEditingController();
  String x;
  var z;
  int pres, con, y;
  @override
  Widget build(BuildContext context1) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Leisure"),
              centerTitle: true,
            ),
            body: Container(
                child: StreamBuilder(
                    stream: firestoreInstance
                        .collection("students")
                        .doc(firebaseUser.uid)
                        .snapshots(),
                    builder: (context1, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        default:
                          pres = snapshot.data["present"];
                          con = snapshot.data["conducted"];
                          return Container(
                              child: SingleChildScrollView(
                                  child: SafeArea(
                                      child: Center(
                                          child: Container(
                                              padding: EdgeInsets.all(20.0),
                                              //color: Colors.white,

                                              width: 356,
                                              child: Column(children: <Widget>[
                                                SizedBox(
                                                  height: 100,
                                                ),
                                                Text("Student Name : " +
                                                    snapshot.data["name"]
                                                        .toString()
                                                        .toUpperCase()),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Semester / Section : " +
                                                    snapshot.data["sem"]
                                                        .toString()
                                                        .toUpperCase()),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                    "Number of classes Conducted : " +
                                                        snapshot
                                                            .data["conducted"]
                                                            .toString()
                                                            .toUpperCase()),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                    "Number of classes present : " +
                                                        snapshot.data["present"]
                                                            .toString()
                                                            .toUpperCase()),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Current attendance : " +
                                                    ((pres / con) * 100)
                                                        .toString()),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  height: 50.0,
                                                  child: TextFormField(
                                                      controller: myController,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                        hintText:
                                                            'no of classes you want to take leave',
                                                        filled: true,
                                                        fillColor:
                                                            new Color.fromRGBO(
                                                                0, 0, 0, 240.0),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 14.0,
                                                                bottom: 8.0,
                                                                top: 8.0),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ButtonTheme(
                                                  minWidth: 150.0,
                                                  height: 40.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      15.0,
                                                    ),
                                                  ),
                                                  child: RaisedButton(
                                                    onPressed: () => {
                                                      x = myController.text
                                                          as String,
                                                      y = int.parse(x),
                                                      z = ((pres) / (con + y)) *
                                                          100,
                                                      Fluttertoast.showToast(
                                                        toastLength:
                                                            Toast.LENGTH_LONG,
                                                        msg:
                                                            "Attendence after taking leave " +
                                                                z.toString(),
                                                      )
                                                    },
                                                    color: Colors.blueGrey,
                                                    elevation: 4.0,
                                                    child: Text(
                                                      "predict".toUpperCase(),
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  height: 120,
                                                ),
                                                ButtonTheme(
                                                  minWidth: 150.0,
                                                  height: 40.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      15.0,
                                                    ),
                                                  ),
                                                  child: RaisedButton(
                                                    onPressed: () => {
                                                      context
                                                          .read<
                                                              AuthenticationService>()
                                                          .signOut(),
                                                    },
                                                    color: Colors.redAccent,
                                                    elevation: 4.0,
                                                    child: Text(
                                                      "Logout",
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]))))));
                      }
                    }))));
  }
}
