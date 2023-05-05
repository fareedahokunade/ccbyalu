import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';

import 'home.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _secureStorage = FlutterSecureStorage();

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
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/images/img_base.png',
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
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create An Account',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.blueGrey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          child: TextFormField(
                            controller: nameController,
                            cursorColor: Colors.white,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 16.0),
                            decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: 'Enter your name',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ),
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
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                            ),
                          ),
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
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text(
                            ' Already have an account? Sign In',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              letterSpacing: 0,
                              color: Colors.blue.withOpacity(1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 500,
                        child: Transform.rotate(
                          angle: 3.139,
                          child: Image.asset(
                            'assets/images/img_ellipse756_157x375.png',
                            fit: BoxFit.fill,
                          ),
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
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors.blueGrey.withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                              fontFamily: 'Cabin',
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          onPressed: signUp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(nameController.text.trim());
        await _storeUserToken(user.uid);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _storeUserToken(String userId) async {
    await _secureStorage.write(key: 'user_token', value: userId);
  }
}
