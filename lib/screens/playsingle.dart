import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/screens/level.dart';

// import 'package:dailyhungryheros/screens/single_screen.dart';
import 'package:flutter/material.dart';

// import '../model/level.dart';

class PlaySingle extends StatefulWidget {
  const PlaySingle({Key? key}) : super(key: key);

  @override
  State<PlaySingle> createState() => _PlaySingleState();
}

class _PlaySingleState extends State<PlaySingle> {
  Image image = Image.asset('assets/topic/icon/family.png');
  List<Widget> ls = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('levels')
              .orderBy('id')
              .snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              for (var element in snapshot.data!.docs) {
                final row = element.data() as Map<String, dynamic>;
                ls.add(Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image.asset(
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                      'assets/img/c.jpg',
                    ),
                    Container(
                      width: 50,
                      margin: EdgeInsets.only(right: 200, bottom: 80),
                      alignment: AlignmentDirectional.centerStart,
                      child: Image.asset(
                        'assets/topic/icon/' + row['topic'][1],
                        // width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(100),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, _, __) => LevelScreen(
                                      topic: row['topic'][0],
                                      level: row['id']
                                    ),
                                opaque: false),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.width / 1.5,
                          alignment: AlignmentDirectional.bottomCenter,
                          child: const Image(
                            image: AssetImage('assets/img/level.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
              }
            }
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: <Widget>[
                  Row(
                    children: ls,
                  )
                ]));
          }),
        ),
       
        Container(
          margin: const EdgeInsets.only(left: 30, bottom: 120), //50

          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.width / 2.5,
          alignment: AlignmentDirectional.bottomStart,
          child: Image(
            image: const AssetImage('assets/img/arthor.png'),
          ),
        ),
      ],
    );
  }
}
