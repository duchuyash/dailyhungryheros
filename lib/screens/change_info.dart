// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangeInfo extends StatefulWidget {
  const ChangeInfo({super.key});

  @override
  State<ChangeInfo> createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  final auth = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;

  String nickname = '';
  TextEditingController newnickname = TextEditingController();
  Future getUser() async {
    final userRef = firestore.collection('users').doc(auth.uid);
    final user = await userRef.get();
    final doc = user.data();
    nickname = doc!['nickname'];
  }

  Future updateUser(String newname) async {
    firestore.collection('users').doc(auth.uid).update({'nickname': newname});

    nickname = newname;
  }

  @override
  void initState() {
    super.initState();

    getUser().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Change your nickname',
        style: TextStyle(color: Colors.blue, fontSize: 20),
      ),
      content: Container(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: ((value) =>
              value != null && value.length > 2 && value.length < 8
                  ? null
                  : 'Invalid nickname'),
          controller: newnickname,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.account_circle_sharp,
              color: Colors.black45,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.5),
            focusColor: Colors.brown,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              gapPadding: 5.0,
            ),
            hintText: nickname,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              updateUser(newnickname.text);
            });
            Navigator.pop(context);
            final snackBar = SnackBar(
              content: Text('Change nickname success'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: const Text('Save'),
        ),
      ],
    );

    // Container(
    //   decoration: BoxDecoration(
    //     color: Colors.black.withOpacity(0.6),
    //   ),
    //   child: Center(
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: Colors.pink[200],
    //         borderRadius: BorderRadius.circular(20),
    //       ),
    //       height: MediaQuery.of(context).size.height * 1 / 3,
    //       width: MediaQuery.of(context).size.width * 0.9,
    //       child: Column(
    //         children: [
    //           Expanded(
    //             flex: 1,
    //             child: SizedBox(
    //               height: 20,
    //               child: Row(children: [
    //                 TextButton(
    //                     onPressed: () {
    //                       Navigator.pop(context);
    //                     },
    //                     child: const Icon(
    //                       Icons.close_sharp,
    //                       color: Colors.white,
    //                     ))
    //               ]),
    //             ),
    //           ),
    //           Expanded(
    //             flex: 8,
    //             child: Container(
    //               child: TextFormField(
    //                 autovalidateMode: AutovalidateMode.onUserInteraction,
    //                 validator: ((value) =>
    //                     value != null && value.length > 2 && value.length < 8
    //                         ? 'Nickname không hợp lệ'
    //                         : null),
    //                 controller: newnickname,
    //                 decoration: InputDecoration(
    //                   prefixIcon: const Icon(
    //                     Icons.account_circle_sharp,
    //                     color: Colors.black45,
    //                   ),
    //                   filled: true,
    //                   fillColor: Colors.white.withOpacity(0.5),
    //                   focusColor: Colors.brown,
    //                   border: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(20),
    //                     gapPadding: 5.0,
    //                   ),
    //                   hintText: nickname,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Expanded(
    //             flex: 1,
    //             child: SizedBox(
    //               height: 20,
    //               child: ElevatedButton(
    //                 style: ButtonStyle(
    //                   backgroundColor: MaterialStateProperty.all(Colors.brown),
    //                 ),
    //                 onPressed: () {
    //                   setState(() {
    //                     updateUser(newnickname.text);
    //                   });
    //                   Navigator.pop(context);
    //                   final snackBar = SnackBar(
    //                     content: Text('Change nickname success'),
    //                   );
    //                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //                 },
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(100)),
    //                   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    //                   child: const Text(
    //                     'Save',
    //                     style: TextStyle(
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 15),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
