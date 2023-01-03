import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/screens/shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile_Info extends StatefulWidget {
  const Profile_Info({super.key});

  @override
  State<Profile_Info> createState() => _Profile_InfoState();
}

class _Profile_InfoState extends State<Profile_Info> {
  final auth = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;
  int rank = 0;
  int imgrank = 0;
  Future getUser() async {
    final userRef = firestore.collection('users').doc(auth.uid);
    final user = await userRef.get();
    final doc = user.data();
    rank = doc!['rank'] % 5;
    imgrank = doc['rank'] ~/ 5;
  }

  @override
  void initState() {
    super.initState();

    getUser().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.green[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      margin: const EdgeInsets.all(10),
                      alignment: AlignmentDirectional.center,
                      child: Image.asset(
                        'assets/icon/rank-$imgrank' '.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            padding: const EdgeInsets.only(bottom: 50),
                            alignment: AlignmentDirectional.centerEnd,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: rank,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 50,
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            padding: const EdgeInsets.only(bottom: 50),
                            alignment: AlignmentDirectional.centerEnd,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 5 - rank,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star_border,
                                color: Colors.yellow,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                children: [
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width * 2.5 / 3,
                  //       height: 70,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Row(
                  //             children: <Widget>[
                  //               Padding(
                  //                 padding: const EdgeInsets.only(left: 5),
                  //                 child: Image(
                  //                   image:
                  //                       const AssetImage('assets/icon/ask.png'),
                  //                   width:
                  //                       MediaQuery.of(context).size.height / 20,
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //               ),
                  //               const Padding(
                  //                 padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  //                 child: Text(
                  //                   '3',
                  //                   style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: 15,
                  //                       fontWeight: FontWeight.bold),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Row(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: <Widget>[
                  //               Padding(
                  //                 padding: const EdgeInsets.only(left: 5),
                  //                 child: Image(
                  //                   image: const AssetImage(
                  //                       'assets/icon/50-50.png'),
                  //                   width:
                  //                       MediaQuery.of(context).size.height / 20,
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //               ),
                  //               const Padding(
                  //                 padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  //                 child: Text(
                  //                   '1',
                  //                   style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: 15,
                  //                       fontWeight: FontWeight.bold),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Row(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: <Widget>[
                  //               Padding(
                  //                 padding: const EdgeInsets.only(left: 5),
                  //                 child: Image(
                  //                   image: const AssetImage(
                  //                       'assets/icon/pass.png'),
                  //                   width:
                  //                       MediaQuery.of(context).size.height / 20,
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //               ),
                  //               const Padding(
                  //                 padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  //                 child: Text(
                  //                   '1',
                  //                   style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: 15,
                  //                       fontWeight: FontWeight.bold),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: IconButton(
                  //         onPressed: () => Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (content) => Shop(),
                  //           ),
                  //         ),
                  //         icon: const Icon(
                  //           Icons.shopping_cart,
                  //           color: Colors.white,
                  //           size: 30,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ));
  }
}
