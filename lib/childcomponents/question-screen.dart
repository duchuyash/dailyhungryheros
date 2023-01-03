// ignore_for_file: file_names
import 'package:dailyhungryheros/screens/change_info.dart';
import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:dailyhungryheros/screens/single_screen.dart';
import 'package:flutter/material.dart';
import '../model/question.dart';

class QuestionScreen extends StatefulWidget {
  QuestionScreen({super.key, required this.item});

  Question item;
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 210, 97),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.item.question,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: Row(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   Play.question == 10
                        //       ? Navigator.of(context)
                        //           .pop((route) => route.isFirst)
                        //       : Play.question++;
                        // });
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                        width: (MediaQuery.of(context).size.width - 30) / 2,
                        height: MediaQuery.of(context).size.height / 6 - 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.item.answers[0],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                        width: (MediaQuery.of(context).size.width - 30) / 2,
                        height: MediaQuery.of(context).size.height / 6 - 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.item.answers[1],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                        width: (MediaQuery.of(context).size.width - 30) / 2,
                        height: MediaQuery.of(context).size.height / 6 - 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.item.answers[2],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                        width: (MediaQuery.of(context).size.width - 30) / 2,
                        height: MediaQuery.of(context).size.height / 6 - 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.item.answers[3],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
