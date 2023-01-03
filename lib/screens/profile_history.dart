import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/childcomponents/historyitem.dart';
import 'package:dailyhungryheros/childcomponents/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Profile_History extends StatefulWidget {
  const Profile_History({super.key});

  @override
  State<Profile_History> createState() => _Profile_HistoryState();
}

class _Profile_HistoryState extends State<Profile_History> {
  var lsItems = HistoryItem.lsItems;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.green[400],
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('historys')
            .where('email', isEqualTo: user.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final history = snapshot.data!.docs;

          return ListView.builder(
              itemCount: history.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                              alignment: AlignmentDirectional.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Text(
                                      ('level ${history[index]['level']}')
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 22, 97, 159),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    child: Text(
                                      (history[index]['score'] * 10)
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 22, 97, 159),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat('kk:mm:ss a dd-MM-yyyy').format(
                                  DateTime.parse(
                                    history[index]['time'].toDate().toString(),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
              });
        },
      ),
    );
  }
}

// ListView.builder(
//               padding: const EdgeInsets.all(8),
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                     height: MediaQuery.of(context).size.height / 8,
//                     margin: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.green[200],
//                       border: Border.all(width: 2, color: Colors.white),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Container(
//                               alignment: AlignmentDirectional.center,
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Expanded(
//                                     flex: 1,
//                                     child: Container(
//                                       margin: const EdgeInsets.all(5.0),
//                                       child: Image.asset(
//                                         'assets/icon/rank-${lsItems[index].rank}.png',
//                                         width:
//                                             MediaQuery.of(context).size.width /
//                                                 5,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 1,
//                                     child: Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           0, 10, 10, 10),
//                                       child: Image.asset(
//                                         lsItems[index].avatar,
//                                         width:
//                                             MediaQuery.of(context).size.width /
//                                                 6,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 2,
//                                     child: Text(
//                                       lsItems[index].name.toUpperCase(),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 IconButton(
//                                   onPressed: () {
//                                     const snackBar = SnackBar(
//                                         content: Text('Sent a friend request'));

//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(snackBar);
//                                   },
//                                   icon: const Icon(
//                                     Icons.group_add,
//                                     color: Colors.white,
//                                     size: 30,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Icon(
//                                     (index % 2) == 0
//                                         ? Icons.keyboard_double_arrow_up
//                                         : Icons.keyboard_double_arrow_down,
//                                     color: (index % 2) == 0
//                                         ? Color.fromARGB(255, 22, 97, 159)
//                                         : Colors.red,
//                                     size: 50,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child:
//                                   Text('${lsItems[index].timeago} minius ago'),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ));
//               });
