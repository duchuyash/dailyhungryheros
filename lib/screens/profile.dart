import 'package:dailyhungryheros/childcomponents/top-nav-profile.dart';
import 'package:dailyhungryheros/childcomponents/top-nav-shop.dart';
import 'package:dailyhungryheros/screens/change_info.dart';
import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:dailyhungryheros/screens/profile_history.dart';
import 'package:dailyhungryheros/screens/profile_info.dart';
import 'package:dailyhungryheros/screens/shop_diamonds.dart';
import 'package:dailyhungryheros/screens/shop_help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Widget> lstScreen = [
    const Profile_Info(),
    const Profile_History(),
  ];

  var selectedIndex = 0;
  // ignore: non_constant_identifier_names
  void OntabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(
            double.infinity,
            selectedIndex == 0
                ? MediaQuery.of(context).size.height * 0.9 / 3
                : kToolbarHeight),
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
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    selectedIndex == 0
                        ? IconButton(
                            icon: const Icon(
                              Icons.edit_note,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ChangeInfo();
                                  }).then((value) {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (content) => Profile(),
                                  ),
                                );
                              });
                            },
                          )
                        : Container(),
                  ],
                ),
                selectedIndex == 0 ? const TopNavProfile() : Container(),
              ],
            )),
      ),
      body: lstScreen[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: selectedIndex == 0
                      ? MaterialStatePropertyAll<Color>(Colors.pink[200]!)
                      : MaterialStatePropertyAll<Color>(
                          Colors.pink[200]!.withOpacity(0.3)),
                ),
                onPressed: () => OntabSelected(0),
                icon: Image.asset(
                  'assets/icon/info.png',
                  width: 30,
                ),
                label: const Text(
                  'Infomation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: selectedIndex == 1
                      ? MaterialStatePropertyAll<Color>(Colors.pink[200]!)
                      : MaterialStatePropertyAll<Color>(
                          Colors.pink[200]!.withOpacity(0.3)),
                ),
                onPressed: () => OntabSelected(1),
                icon: Image.asset(
                  'assets/icon/history.png',
                  width: 30,
                ),
                label: const Text(
                  'History',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
