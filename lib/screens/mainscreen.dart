import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/screens/playdual.dart';
import 'package:dailyhungryheros/screens/profile.dart';
import 'package:dailyhungryheros/screens/shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../childcomponents/menu.dart';
import 'package:dailyhungryheros/screens/playsingle.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final auth = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  final us = FirebaseAuth.instance.currentUser!;

  List<Widget> lstScreen = [
    PlaySingle(),
  ];

  int selectedIndex = 0;

  void OntabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  late int time = 0;

  int heart = 0;

  int diamond = 1024;

  formatedTime({required int timeInSecond}) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  Future getHeart() async {
    final us = FirebaseAuth.instance.currentUser!;

    final userRef = FirebaseFirestore.instance.collection('users').doc(us.uid);
    final user = await userRef.get();
    final doc = user.data();
    heart = doc!['heart'];
  }

  Future updateHeart(int heart) async {
    final us = FirebaseAuth.instance.currentUser!;

    final userRef = FirebaseFirestore.instance.collection('users').doc(us.uid);
    userRef.update({'heart': heart});
  }

  @override
  void initState() {
    super.initState();
    getHeart().then((value) => setState(() {
          if (heart < 5) {
            runTime();
          }
        }));
  }

  void runTime() {
    if (heart < 5) {
      Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (mounted)
          setState(() {
            time++;
          });
        if (time == 300) {
          heart++;
          updateHeart(heart);
          timer.cancel();
          time = 0;
          runTime();
          return;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border:
                const Border(bottom: BorderSide(color: Colors.white, width: 2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Color.fromARGB(255, 22, 97, 159),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/icon/heart.png',
                          width: MediaQuery.of(context).size.height / 23,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(14, 8, 0, 0),
                          child: Text(
                            heart.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text(
                      heart == 5 ? 'MAX' : formatedTime(timeInSecond: time),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Image.asset(
                      'assets/icon/diamond.png',
                      width: MediaQuery.of(context).size.height / 23,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(
                      diamond.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: PlaySingle(),
      endDrawer: Menu(),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 12,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: const Border(top: BorderSide(color: Colors.white, width: 2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Color.fromARGB(255, 22, 97, 159),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: _openEndDrawer,
              child: Image.asset('assets/icon/menu.png'),
            ),
            TextButton(
              onPressed: () {
                OntabSelected(0);
              },
              child: Image.asset(
                'assets/icon/home.png',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayDual(),
                  ),
                ).then((value) async {
                  await firestore
                      .collection('counters')
                      .doc('wait')
                      .get()
                      .then((value) {
                    if (value.exists) {
                      if (value.get('counter') % 2 != 0) {
                        firestore
                            .collection('matches')
                            .doc((value.get('counter') - 1).toString())
                            .delete();
                        firestore
                            .collection('counters')
                            .doc('wait')
                            .update({'counter': value.get('counter') - 1});
                      }
                    }
                  });
                });
              },
              child: Image.asset('assets/icon/pk.png'),
            ),
          ],
        ),
      ),
    );
  }
}
