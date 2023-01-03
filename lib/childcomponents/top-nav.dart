import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/screens/change_info.dart';
import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopNav extends StatefulWidget {
  const TopNav({Key? key}) : super(key: key);

  @override
  State<TopNav> createState() => _TopNavState();
}

class _TopNavState extends State<TopNav> {
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
    return 
    Row(
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
    );
  }
}
