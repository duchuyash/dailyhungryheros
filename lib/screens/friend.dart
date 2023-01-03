import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../childcomponents/historyitem.dart';

class Friend extends StatefulWidget {
  const Friend({super.key});

  @override
  State<Friend> createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
              double.infinity, MediaQuery.of(context).size.height * 0.9 / 3),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.pink[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              )),
        ),
        body: Container(
          color: Colors.blue[100],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    width: MediaQuery.of(context).size.width / 1.2,
                    padding: const EdgeInsets.fromLTRB(50, 10, 0, 10),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.black),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        hintText: 'Search',
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Image.asset(
                        'assets/icon/add-friend.png',
                        width: 32,
                      ))
                ],
              ),
              Container(
                  height: MediaQuery.of(context).size.height - 200,
                  color: Colors.blue[100],
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('email', isNotEqualTo: auth.email)
                        .snapshots(),
                    builder: ((context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final lsItems = snapshot.data!.docs;
                      return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: lsItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                height: MediaQuery.of(context).size.height / 8,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  border: Border.all(
                                    width: 2,
                                    color: Color.fromARGB(255, 22, 97, 159),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                          padding: EdgeInsets.all(5),
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: Image.asset(
                                                        'assets/icon/rank-${lsItems[index]['rank'] ~/ 5}.png',
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            7,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            lsItems[index]
                                                                    ['rank'] %
                                                                5,
                                                        itemBuilder:
                                                            (context, index) =>
                                                                const Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  lsItems[index]['nickname']
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 22, 97, 159),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {},
                                                child: Image.asset(
                                                  'assets/icon/comments.png',
                                                  width: 40,
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ));
                          });
                    }),
                  ))
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.9 / 13,
          decoration: BoxDecoration(
            color: Colors.pink[200],
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ));
  }
}
