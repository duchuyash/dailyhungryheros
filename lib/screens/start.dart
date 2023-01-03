import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'loginbackground.gif',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: AlignmentDirectional.center,
          child: DropShadow(
            blurRadius: 5,
            offset: const Offset(5, 5),
            spread: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'logo.png',
                  width: MediaQuery.of(context).size.width / 1.5,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.brown),
                        ),
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.brown),
                        ),
                        onPressed: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
