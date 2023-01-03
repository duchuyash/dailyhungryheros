// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/model/highscore.dart';
import 'package:dailyhungryheros/model/level.dart';
import 'package:dailyhungryheros/screens/level.dart';
import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:dailyhungryheros/screens/playdual.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/question.dart';
import 'single_screen.dart';

class ResultDual extends StatefulWidget {
  ResultDual({
    Key? key,
    required this.result,
  }) : super(key: key);

  final int result;

  @override
  State<ResultDual> createState() => _ResultDualState();
}

class _ResultDualState extends State<ResultDual> {
  final auth = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;

  int rank = 0;

  Future getUser() async {
    await firestore.collection('users').doc(auth.uid).get().then((value) {
      setState(() {
        rank = value.get('rank');
      });
    });
  }

  Future update() async {
    int match = 0;

    await firestore.collection('counters').doc('wait').get().then((value) {
      match = value.get('counter') - 2;
    });
    final doc = firestore.collection('matches').doc(match.toString());
    doc.get().then((value) {
      if (auth.uid == value.get('user1')[0]) {
        var ls = value.get('user1');
        ls[2] = widget.result;
        doc.update({'user1': ls});
      } else {
        var ls = value.get('user2');
        ls[2] = widget.result;
        doc.update({'user2': ls});
      }
    });
  }

  String uid1 = '';
  String uid2 = '';
  int result1 = 0;
  int result2 = 0;
  bool? isUp;

  Future getMatch() async {
    int match = 0;

    await firestore.collection('counters').doc('wait').get().then((value) {
      match = value.get('counter') - 2;
    });
    await firestore
        .collection('matches')
        .doc(match.toString())
        .get()
        .then((value) {
      uid1 = auth.uid;
      if (uid1 == value.get('user1')[0]) {
        if (mounted) {
          setState(() {
            uid2 = value.get('user2')[0];
            result1 = value.get('user1')[2];
            result2 = value.get('user2')[2];
          });
        }
      } else if (uid1 == value.get('user2')[0]) {
        if (mounted) {
          setState(() {
            uid2 = value.get('user1')[0];
            result1 = value.get('user2')[2];
            result2 = value.get('user1')[2];
          });
        }
      }
    });
    // result1 > result2
    //     ? isUp = (rank == 30 ? null : true)
    //     : result1 < result2
    //         ? isUp = (rank == 0 ? null : false)
    //         : isUp = null;
    // await firestore.collection('users').doc(auth.uid).update({
    //   'rank': isUp == true
    //       ? rank++
    //       : isUp == false
    //           ? rank--
    //           : rank
    // });
  }

  @override
  void initState() {
    super.initState();
    getUser().then((value) => setState(() {}));
    update().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    getMatch();
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: AlignmentDirectional.center,
                height: MediaQuery.of(context).size.height * 2 / 3,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(202, 45, 5, 1),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(3, 178, 217, 1),
                ),
              ),
            ],
          ),
          Container(
              height: MediaQuery.of(context).size.height - 20,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(),
                ],
              )),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 2 / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlayDual()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                            child: Image.asset(
                              'assets/icon/back.png',
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                          child: Image.asset(
                            'assets/img/result.webp',
                            width: MediaQuery.of(context).size.width / 2,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: result1 > result2
                            ? Image.asset(
                                'assets/img/win.webp',
                                width: MediaQuery.of(context).size.width / 2,
                                fit: BoxFit.cover,
                              )
                            : result1 < result2
                                ? Image.asset(
                                    'assets/img/lose.webp',
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/img/tie.webp',
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                    ),
                    Text(
                      result1.toString() + ' : ' + result2.toString(),
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Image.asset(
                          'assets/icon/rank-1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Image.asset(
                      'assets/img/next.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Image.asset(
                          'assets/icon/rank-1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
              )
            ],
          )
        ],
      ),
    );
  }
}
