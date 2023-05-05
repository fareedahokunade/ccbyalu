import 'signup.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'login.dart';
import 'signup.dart';

class Intro extends StatefulWidget {
  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            Stack(children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/main.png',
                  height: 550,
                  width: 450,
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
                    height: 30,
                    width: 40,
                  ),
                ),
              ),
            ]),
            Container(
              width: 150,
              alignment: Alignment.center,
              child: Text(
                'Campus Companion by:',
                textAlign: TextAlign.center,
                style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.blueGrey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 50, 0),
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/images/alu.png',
                height: 80,
                width: 80,
              ),
            ),
            Row(children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/img_specular_30x26.png',
                  height: 40,
                  width: 40,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 0, 20, 20),
                alignment: Alignment.center,
                child: Text(
                  'Book and Track Spaces',
                  textAlign: TextAlign.center,
                  style: TextStyle(shadows: [
                    Shadow(
                      color: Colors.blueGrey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ], fontFamily: 'Cabin', fontSize: 15.0),
                ),
              ),
            ]),
            Stack(children: <Widget>[
              Container(
                height: 100,
                width: 500,
                child: Transform.rotate(
                  angle: 3.139, // rotate by 0.5 radians (about 28.6 degrees)
                  child: Image.asset('assets/images/img_ellipse756_157x375.png',
                      fit: BoxFit.fill),
                ),
              ),
              Positioned(
                top: 50,
                left: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  ),
                  child: Text(
                    'Log In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.blueGrey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 80,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  ),
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.blueGrey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                ),
              )
            ]),
          ]))),
    );
  }
}
