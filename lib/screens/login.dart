// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/model/music.dart';
import 'package:dailyhungryheros/screens/getcode.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:dailyhungryheros/screens/ready.dart';
import 'package:dailyhungryheros/screens/register.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final _key = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  BottomDrawerController _controller = BottomDrawerController();
  bool hidePassword = true;
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
                              width: MediaQuery.of(context).size.width / 1,
                              child: Form(
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: ((value) => value != null &&
                                              !EmailValidator.validate(value)
                                          ? 'Invalid email'
                                          : null),
                                      controller: email,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.account_circle_sharp,
                                          color: Colors.black45,
                                        ),
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.5),
                                        focusColor: Colors.brown,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gapPadding: 5.0,
                                        ),
                                        hintText: 'Email',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: ((value) => value != null &&
                                              value.length > 6 &&
                                              value.length < 30
                                          ? 'Invalid password'
                                          : null),
                                      obscureText: hidePassword,
                                      controller: password,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.password_rounded,
                                          color: Colors.black45,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: hidePassword
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              hidePassword = !hidePassword;
                                            });
                                          },
                                        ),
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.5),
                                        focusColor: Colors.brown,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gapPadding: 5.0,
                                        ),
                                        hintText: 'Password',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.brown),
                                      ),
                                      onPressed: login,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
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
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GetCode()),
                        (route) => false),
                    child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Forgot password',
                        style: TextStyle(
                          color: Color.fromARGB(255, 96, 69, 59),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    ).then((value) {
                      if (value != null) {
                        final snackBar = SnackBar(
                          content: Text(value),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
                    child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Sign up',
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
            drawerHeight: 170,
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
                    icon: const Icon(
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

  Future login() async {
    // final isValid = _key.currentState!.validate();
    // if (!isValid) return;
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      final snackBar = SnackBar(
        content: Text('Logged in successfully'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushNamedAndRemoveUntil(context, 'ready', (route) => false);
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(
        content: Text('An error occurred. Please try again later'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    ;
  }
}
