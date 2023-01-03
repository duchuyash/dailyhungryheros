// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TopNavShop extends StatefulWidget {
  const TopNavShop(
      {super.key, required this.ask, required this.haft, required this.pass});

  final int ask;
  final int haft;
  final int pass;

  @override
  State<TopNavShop> createState() => _TopNavShopState();
}

class _TopNavShopState extends State<TopNavShop> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Image(
                      image: const AssetImage('assets/icon/ask.png'),
                      width: MediaQuery.of(context).size.height / 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text(
                      '3',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Image(
                      image: const AssetImage('assets/icon/50-50.png'),
                      width: MediaQuery.of(context).size.height / 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text(
                      '1',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Image(
                      image: const AssetImage('assets/icon/pass.png'),
                      width: MediaQuery.of(context).size.height / 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text(
                      '1',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
