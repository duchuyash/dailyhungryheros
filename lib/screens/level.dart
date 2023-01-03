import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/question.dart';
import 'single_screen.dart';

class LevelScreen extends StatefulWidget {
  LevelScreen({super.key, required this.topic, required this.level});

  int topic;
  int level;
  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  late int heart;

  Future getHeart() async {
    final us = FirebaseAuth.instance.currentUser!;

    final userRef = FirebaseFirestore.instance.collection('users').doc(us.uid);
    final user = await userRef.get();
    final doc = user.data();
    heart = doc!['heart'];
  }

  String name = '';
  Image image = Image.asset('assets/img/c.jpg');

  @override
  void initState() {
    super.initState();
    getHeart().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('topics')
            .where('id', isEqualTo: widget.topic)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final data =
                snapshot.data!.docs.first.data() as Map<String, dynamic>;
            name = data['name'];
            image = Image.asset(
              'assets/topic/image/' + data['image'],
              width: MediaQuery.of(context).size.width / 3,
              fit: BoxFit.cover,
            );
          }
          return Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
            ),
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 3,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 11, 52, 86),
                            border: Border(
                                bottom:
                                    BorderSide(width: 3, color: Colors.white))),
                        child: Row(children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close_sharp,
                                color: Colors.white,
                              )),
                        ]),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            border: const Border(
                                bottom:
                                    BorderSide(width: 3, color: Colors.white))),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  name.toUpperCase(),
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Padding(
                                    padding: EdgeInsets.all(20), child: image)),
                            Expanded(
                              flex: 5,
                              child: Stack(
                                children: [
                                  Container(
                                    alignment: AlignmentDirectional.topCenter,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                'assets/icon/star.png',
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                'assets/icon/star.png',
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                'assets/icon/star.png',
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
                                          .map((e) => Question
                                              .fromQueryDocumentSnapshot(e))
                                          .toList();
                                      return Container(
                                          margin:
                                              const EdgeInsets.only(top: 100),
                                          alignment:
                                              AlignmentDirectional.bottomCenter,
                                          child: TextButton(
                                            child: Image.asset(
                                                'assets/icon/start.png'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (content) =>
                                                      SingleScreen(
                                                    heart: heart,
                                                    level: widget.level,
                                                    lsQuestions: lsQuestions,
                                                  ),
                                                ),
                                              );
                                            },
                                          ));
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 11, 52, 86),
                        ),
                        child: Row(children: []),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
