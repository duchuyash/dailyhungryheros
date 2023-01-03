// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dailyhungryheros/model/question.dart';

class Answer extends StatefulWidget {
  final Question question;
  final bool lock;
  final List<int> select;
  final ValueChanged<int> onClick;

  Answer({
    Key? key,
    required this.question,
    required this.onClick,
    required this.lock,
    required this.select,
  }) : super(key: key);

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  List<int> wrong = [];
  @override
  Widget build(BuildContext context) {
    final lsAnswers = widget.question.answers;
    return Row(
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                if (0 != widget.question.correct) {
                  setState(() {});
                }
                return widget.onClick(0);
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                width: (MediaQuery.of(context).size.width - 30) / 2,
                height: MediaQuery.of(context).size.height / 6 - 10,
                decoration: BoxDecoration(
                  color:
                      getColor(0, widget.question, widget.lock, widget.select),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lsAnswers[0],
                      textAlign: TextAlign.center,
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
              onTap: () => widget.onClick(2),
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                width: (MediaQuery.of(context).size.width - 30) / 2,
                height: MediaQuery.of(context).size.height / 6 - 10,
                decoration: BoxDecoration(
                  color:
                      getColor(2, widget.question, widget.lock, widget.select),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lsAnswers[2],
                      textAlign: TextAlign.center,
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
              onTap: () => widget.onClick(1),
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                width: (MediaQuery.of(context).size.width - 30) / 2,
                height: MediaQuery.of(context).size.height / 6 - 10,
                decoration: BoxDecoration(
                  color:
                      getColor(1, widget.question, widget.lock, widget.select),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lsAnswers[1],
                      textAlign: TextAlign.center,
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
              onTap: () => widget.onClick(3),
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                width: (MediaQuery.of(context).size.width - 30) / 2,
                height: MediaQuery.of(context).size.height / 6 - 10,
                decoration: BoxDecoration(
                  color:
                      getColor(3, widget.question, widget.lock, widget.select),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lsAnswers[3],
                      textAlign: TextAlign.center,
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
    );
  }

  Color getColor(int answer, Question question, bool lock, List<int> select) {
    if (lock) {
      if (select.contains(answer)) {
        return answer == question.correct ? Colors.blue : Colors.red;
      }
    }
    return Colors.green;
  }
}
