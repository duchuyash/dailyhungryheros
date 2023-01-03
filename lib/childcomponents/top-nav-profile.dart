// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopNavProfile extends StatefulWidget {
  const TopNavProfile({super.key});

  @override
  State<TopNavProfile> createState() => _TopNavProfileState();
}

class _TopNavProfileState extends State<TopNavProfile> {
  String nickname = '';
  int exp = 0;
  int heart = 0;

  Future getUser() async {
    final us = FirebaseAuth.instance.currentUser!;

    final userRef = FirebaseFirestore.instance.collection('users').doc(us.uid);
    final user = await userRef.get();
    final doc = user.data();
    nickname = doc!['nickname'];
    exp = doc['exp'];
    heart = doc['heart'];
  }

  @override
  void initState() {
    super.initState();

    getUser().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 8,
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    width: 3,
                    color: Color.fromARGB(255, 22, 97, 159),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          '$nickname'.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 22, 97, 159),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/img/avatar.jpg',
                width: MediaQuery.of(context).size.width / 3,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset(
                            'assets/icon/exp.png',
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          (exp ~/ 100).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icon/heart.png',
                          width: MediaQuery.of(context).size.height / 28,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(14, 8, 0, 0),
                          child: Text(
                            heart.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 7,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 225, 205, 21)
                          .withOpacity(0.5)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * ((exp / 100) % 1),
                  height: 5,
                  decoration: const BoxDecoration(color: Colors.yellow),
                ),
              ])
            ],
          )
        ],
      ),
    );
  }
}
