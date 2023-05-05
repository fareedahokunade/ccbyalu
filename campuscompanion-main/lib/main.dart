import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'login.dart';
import 'signup.dart';
import 'home.dart';
import 'intro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Companion',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Splash(),
      routes: {
        // Main initial route

        // Second route
        '/second': (context) => Intro(),
        '/third': (context) => Login(),
        '/fourth': (context) => Signup(),
      },
      initialRoute: '/',
    );
  }
}

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    );

    _animationController!.forward();

    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Home();
                } else {
                  return Intro();
                }
              },
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 150),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 50, 0),
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/img_base.png',
                height: 40,
                width: 40,
              ),
            ),
            Container(height: 100),
            ScaleTransition(
              scale: _animation!,
              child: Container(
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
                        offset: Offset(0, 3),
                      ),
                    ],
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
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
            Container(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/images/clock-dynamic-clay.png',
                height: 40,
                width: 40,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/pin-dynamic-gradient.png',
                height: 40,
                width: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
