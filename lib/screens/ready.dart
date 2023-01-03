import 'package:dailyhungryheros/screens/login.dart';
import 'package:dailyhungryheros/screens/mainscreen.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Ready extends StatefulWidget {
  const Ready({super.key});

  @override
  State<Ready> createState() => _ReadyState();
}

class _ReadyState extends State<Ready> {
  BottomDrawerController _controller = BottomDrawerController();
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/img/loginbackground.gif',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: AlignmentDirectional.center,
                    child: DropShadow(
                      blurRadius: 5,
                      offset: const Offset(5, 5),
                      spread: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        height: MediaQuery.of(context).size.height - 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/logo.png',
                              width: MediaQuery.of(context).size.width / 1.5,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              margin: const EdgeInsets.all(40),
                              child: TextButton(
                                onPressed: () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()),
                                    (route) => false),
                                child: Image.asset(
                                  'assets/icon/start.png',
                                  width: MediaQuery.of(context).size.width / 3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          BottomDrawer(
            header: Container(
              alignment: AlignmentDirectional.topCenter,
              width: MediaQuery.of(context).size.width,
            ),
            body: Container(
              alignment: AlignmentDirectional.bottomEnd,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      const snackBar = SnackBar(
                        content: Text('Logged out'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                          (route) => false);
                    },
                    child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Sign out',
                        style: TextStyle(
                          color: Color.fromARGB(255, 96, 69, 59),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            headerHeight: 0,
            drawerHeight: 120,
            color: Colors.white.withOpacity(0.5),
            controller: _controller,
          ),
          Container(
              alignment: AlignmentDirectional.bottomEnd,
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      status = !status;
                      return status ? _controller.open() : _controller.close();
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
