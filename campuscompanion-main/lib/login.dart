import 'package:flutter/material.dart';
import 'dart:async';
import 'home.dart';
import 'signup.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/images/main.png',
                          height: 30,
                          width: 40,
                        ),
                      ),
                      Positioned(
                        top: 350,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            'assets/images/img_base.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                    ]),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login To Your Account',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            shadows: [
                              Shadow(
                                color: Colors.blueGrey.withOpacity(0.5),
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            fontFamily: 'Cabin',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: TextFormField(
                                controller: emailController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                style: TextStyle(fontSize: 16.0),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Enter your school email',
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                            child: TextFormField(
                                controller: passwordController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                style: TextStyle(fontSize: 16.0),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueGrey),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()),
                            );
                          },
                          child: Text(
                            ' Dont have an account, Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              letterSpacing: 0,
                              color: Colors.blue.withOpacity(1),
                            ),
                          ),
                        ),
                    Stack(children: <Widget>[
                      Container(
                        height: 100,
                        width: 500,
                        child: Transform.rotate(
                          angle:
                              3.139, // rotate by 0.5 radians (about 28.6 degrees)
                          child: Image.asset(
                              'assets/images/img_ellipse756_157x375.png',
                              fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Image.asset(
                          'assets/images/clock-dynamic-clay.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 170,
                        child: ElevatedButton(
                          child: Text(
                            'Log In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    color: Colors.blueGrey.withOpacity(0.5),
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                fontFamily: 'Cabin',
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                          ),
                          onPressed: signIn,
                        ),
                      ),
                    ]),
                  ]));
            }
          }),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }
}
