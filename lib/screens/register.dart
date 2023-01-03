// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailyhungryheros/screens/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:bottom_drawer/bottom_drawer.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  final _key = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController nickname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

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
                                    padding: const EdgeInsets.all(8),
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
                                          Icons.email_rounded,
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
                                    padding: const EdgeInsets.all(5),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: ((value) => value != null &&
                                              value.length > 2 &&
                                              value.length < 8
                                          ? null
                                          : 'Invalid nickname'),
                                      controller: nickname,
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
                                        hintText: 'Nickname',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: ((value) => value != null &&
                                              value.length < 6 &&
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
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility),
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
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: ((value) =>
                                          value != password.text
                                              ? 'Confirm password does not match'
                                              : null),
                                      obscureText: hidePassword,
                                      controller: confirmpassword,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.confirmation_num_outlined,
                                          color: Colors.black45,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: hidePassword
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility),
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
                                        hintText: 'Confirm password',
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
                                      onPressed: () {
                                        setState(() {
                                          register();
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                        child: const Text(
                                          'Sign up',
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
                        MaterialPageRoute(builder: (context) => const Login()),
                        (route) => false),
                    child: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Back to Sign in',
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

  Future register() async {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'email': email.text,
        'nickname': nickname.text,
        'exp': 100,
        'heart': 5,
        'rank': 0
      });

      Navigator.pop(
        context,
        'Sign up Success, please sign in',
      );
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(
        content: Text('An error occurred. Please try again later'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    ;
  }
}
