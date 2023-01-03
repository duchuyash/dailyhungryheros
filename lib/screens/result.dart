// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/model/highscore.dart';
import 'package:dailyhungryheros/model/level.dart';
import 'package:dailyhungryheros/screens/level.dart';
import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/question.dart';
import 'single_screen.dart';

class Result extends StatefulWidget {
  Result({
    Key? key,
    required this.level,
    required this.result,
    required this.time,
    required this.heart,
  }) : super(key: key);

  final int level;
  final int result;
  final int time;
  final int heart;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late int level;
  late int result;
  late int time;
  String nickname = '';

  Future getUser() async {
    final us = FirebaseAuth.instance.currentUser!;

    final userRef = FirebaseFirestore.instance.collection('users').doc(us.uid);
    final user = await userRef.get();
    final doc = user.data();
    nickname = doc!['nickname'];
  }

  Future update() async {
    final us = FirebaseAuth.instance.currentUser!;

    final int plus = result * 5;
    final users = FirebaseFirestore.instance.collection('users').doc(us.uid);
    final x = await users.get();
    users.update({
      'heart': widget.heart,
      'exp': x['exp'] + plus,
    });

    final highscores =
        FirebaseFirestore.instance.collection('highscores').doc('$level');

    final doc = await highscores.get();
    if (doc.exists) {
      final score = doc.data();

      final st = score!['first'];
      final nd = score['second'];
      final rd = score['third'];

      if (st[0] == 0) {
        highscores.update({
          'first': [us.uid, result, time, nickname]
        });
      } else {
        if (result >= st[1]) {
          if (result > st[1] || (result == st[1] && time < st[2])) {
            highscores.update({
              'second': [st[0], st[1], st[2], st[3]]
            });

            highscores.update({
              'first': [us.uid, result, time, nickname]
            });
          } else {
            highscores.update({
              'second': [us.uid, result, time, nickname]
            });
          }
        } else {
          if (nd[0] == 0) {
            highscores.update({
              'second': [us.uid, result, time, nickname]
            });
          } else {
            if (result >= nd[1]) {
              if (result > nd[1] || (result == nd[1] && time < nd[2])) {
                highscores.update({
                  'third': [nd[0], nd[1], nd[2], nd[3]]
                });

                highscores.update({
                  'second': [us.uid, result, time, nickname]
                });
              } else {
                highscores.update({
                  'third': [us.uid, result, time, nickname]
                });
              }
            } else {
              if (rd[0] == 0 || result >= rd[1]) {
                if (result > rd[1] || (result == rd[1] && time < rd[2])) {
                  highscores.update({
                    'third': [us.uid, result, time, nickname]
                  });
                }
              }
            }
          }
        }
      }
    } else {
      highscores.set({
        'first': [
          us.uid,
          result,
          time,
          nickname,
        ],
        'second': [0, 0, 0, 0],
        'third': [0, 0, 0, 0]
      });
    }
    final history = FirebaseFirestore.instance.collection('historys').add({
      'level': level,
      'score': result,
      'time': Timestamp.now(),
      'email': us.email
    });
  }

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  void initState() {
    super.initState();
    level = widget.level;
    result = widget.result;
    time = widget.time;
    getUser();
    update().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          height: 100,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 11, 52, 86),
              border:
                  Border(bottom: BorderSide(width: 3, color: Colors.white))),
          child: Row(children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                      (route) => false);
                },
                child: const Icon(
                  Icons.close_sharp,
                  color: Colors.white,
                )),
          ]),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: (MediaQuery.of(context).size.height - 110) * 1.8 / 3,
            decoration: BoxDecoration(
                color: Colors.blue[200],
                border: const Border(
                    bottom: BorderSide(width: 3, color: Colors.white))),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icon/exam.png',
                                width: 30,
                              ),
                              Text(
                                widget.result.toString() + '/10',
                                style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/clock.png',
                              width: 30,
                            ),
                            Text(
                              formatedTime(timeInSecond: widget.time)
                                  .toString(),
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: AlignmentDirectional.topCenter,
                  height: MediaQuery.of(context).size.height / 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Opacity(
                            opacity: result > 2 ? 1 : 0.5,
                            child: Image.asset(
                              'assets/icon/star.png',
                              width: MediaQuery.of(context).size.width / 3.5,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Opacity(
                            opacity: result > 5 ? 1 : 0.5,
                            child: Image.asset('assets/icon/star.png',
                                width: MediaQuery.of(context).size.width / 3.5,
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Opacity(
                            opacity: result > 9 ? 1 : 0.5,
                            child: Image.asset('assets/icon/star.png',
                                width: MediaQuery.of(context).size.width / 3.5,
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: result > 2
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.center,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('questions')
                            .where('level', isEqualTo: widget.level)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final doc = snapshot.data!.docs;

                          final lsQuestions = doc
                              .map((e) => Question.fromQueryDocumentSnapshot(e))
                              .toList();
                          return Container(
                              width: MediaQuery.of(context).size.width / 3,
                              margin: const EdgeInsets.only(top: 10),
                              child: TextButton(
                                child: Image.asset(
                                  'assets/icon/reset.png',
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);

                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                        pageBuilder: (context, _, __) =>
                                            SingleScreen(
                                              heart: widget.heart,
                                              level: widget.level,
                                              lsQuestions: lsQuestions,
                                            ),
                                        opaque: false),
                                  );
                                },
                              ));
                        },
                      ),
                      result > 2
                          ? StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('questions')
                                  .where('level', isEqualTo: widget.level + 1)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final doc = snapshot.data!.docs;
                                final lsQuestions = doc
                                    .map((e) =>
                                        Question.fromQueryDocumentSnapshot(e))
                                    .toList();
                                return Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  margin: const EdgeInsets.only(top: 10),
                                  child: TextButton(
                                      child: Image.asset(
                                        'assets/icon/next-button.png',
                                        fit: BoxFit.cover,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);

                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, _, __) =>
                                                  LevelScreen(
                                                    topic: widget.level + 1,
                                                    level: widget.level + 1,
                                                  ),
                                              opaque: false),
                                        );
                                      }),
                                );
                              },
                            )
                          : Container(),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: (MediaQuery.of(context).size.height - 100) * 1.2 / 3,
            decoration: BoxDecoration(
                color: Colors.pink[200],
                border: const Border(
                    bottom: BorderSide(width: 3, color: Colors.white))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('highscores')
                    .doc(widget.level.toString())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List<dynamic> ls = [];
                  ls.addAll([
                    snapshot.data!.get('first'),
                    snapshot.data!.get('second'),
                    snapshot.data!.get('third')
                  ]);
                  return Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Image.asset('assets/img/highscore.png'),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 7,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.6,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 28, left: 10),
                                    width: MediaQuery.of(context).size.width /
                                        1.6 /
                                        3,
                                    child: ls[1][3] == 0
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                ls[1][3].toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                (ls[1][1] * 10).toString(),
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.only(top: 10, left: 5),
                                    width: MediaQuery.of(context).size.width /
                                        1.6 /
                                        3,
                                    child: ls[0][3] == 0
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                ls[0][3].toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                (ls[0][1] * 10).toString(),
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 50, right: 10),
                                    width: MediaQuery.of(context).size.width /
                                        1.6 /
                                        3,
                                    child: ls[2][3] == 0
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                ls[2][3].toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                (ls[2][1] * 10).toString(),
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                    ],
                  );
                },
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.only(left: 20),
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 11, 52, 86),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Container()),
    );
  }
}
