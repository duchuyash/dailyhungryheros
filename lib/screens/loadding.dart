import 'dart:async';
import 'package:dailyhungryheros/model/question.dart';
import 'package:dailyhungryheros/screens/dual_screen.dart';
import 'package:flutter/material.dart';

class Loadding extends StatefulWidget {
  const Loadding({Key? key, required this.list}) : super(key: key);
  final List<Question> list;

  @override
  State<Loadding> createState() => _LoaddingState();
}

class _LoaddingState extends State<Loadding> {
  int time = 0;

  late bool play = false;
  late Timer timer;
  void runTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          time++;
          if (time == 2) {
            timer.cancel();
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DualScreen(
                        lsQuestions: widget.list,
                      )),
            );
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    runTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(
            top: 10,
            right: 5,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.width / 2.5,
          alignment: AlignmentDirectional.bottomCenter,
          child: Image.asset(
            'assets/img/go321.webp',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
