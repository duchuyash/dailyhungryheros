import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/screens/friend.dart';
import 'package:dailyhungryheros/screens/profile.dart';
import 'package:dailyhungryheros/screens/shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  bool isMusic = true;
  String nickname = '';
  int exp = 0;

  Future getUser() async {
    final us = FirebaseAuth.instance.currentUser!;

    final userRef = FirebaseFirestore.instance.collection('users').doc(us.uid);
    final user = await userRef.get();
    final doc = user.data();
    nickname = doc!['nickname'];
    exp = doc['exp'];
  }

  @override
  void initState() {
    super.initState();

    getUser().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Row(
            children: [
              Container(
                alignment: AlignmentDirectional.bottomCenter,
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 116, 173, 219)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isMusic = !isMusic;
                          isMusic
                              ? VolumeController().setVolume(0)
                              : VolumeController().setVolume(1);
                        });
                      },
                      child: Icon(
                        isMusic ? Icons.volume_off : Icons.volume_up,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    TextButton(
                      onPressed: _closeEndDrawer,
                      child: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    height: MediaQuery.of(context).size.height / 2.8,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/img/avatar.jpg',
                          width: MediaQuery.of(context).size.width / 3,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                nickname,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text(
                            //       'ID: ',
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.black38,
                            //           fontSize: 14),
                            //     ),
                            //     const Text(
                            //       '553007536',
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.black38,
                            //           fontSize: 14),
                            //     ),
                            //     IconButton(
                            //       onPressed: () {
                            //         const snackBar = SnackBar(
                            //           content: Text('Copied id'),
                            //         );

                            //         ScaffoldMessenger.of(context)
                            //             .showSnackBar(snackBar);
                            //       },
                            //       icon: const Icon(
                            //         Icons.copy,
                            //         size: 20,
                            //         color: Colors.black38,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    'assets/icon/diamond.png',
                                    width: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  '1024',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 16),
                                ),
                              ],
                            ),
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
                                      color: Color.fromARGB(255, 225, 205, 21),
                                      fontSize: 16),
                                ),
                              ],
                            )
                          ],
                        ),
                        Stack(children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 4 / 5,
                            height: 7,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 225, 205, 21)
                                    .withOpacity(0.5)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width *
                                (4 / 5) *
                                ((exp / 100) % 1),
                            height: 7,
                            decoration:
                                const BoxDecoration(color: Colors.green),
                          ),
                        ])
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    height: MediaQuery.of(context).size.height * 1.8 / 2.8,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 22, 97, 159),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {
                              _closeEndDrawer();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (content) => Profile(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 30),
                                  child: Image.asset(
                                    'assets/icon/admin.png',
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Profile',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {
                              _closeEndDrawer();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (content) => Friend()),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 30),
                                  child: Image.asset(
                                    'assets/icon/friend.png',
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Friends',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {
                              _closeEndDrawer();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (content) => Shop(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 30),
                                  child: Image.asset(
                                    'assets/icon/shop.png',
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Shop',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content:
                                        const Text('Do you want sign out ?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          FirebaseAuth.instance.signOut();
                                          await Navigator
                                              .pushNamedAndRemoveUntil(
                                            context,
                                            'login',
                                            (route) => false,
                                          );

                                          final snackBar = SnackBar(
                                            content: Text('Logged out'),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 30),
                                  child: Image.asset(
                                    'assets/icon/sign_out.png',
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Text(
                                  'Sign out',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
