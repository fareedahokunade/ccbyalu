import 'userbookings.dart';

import 'book.dart';
import 'myrooms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'addevent.dart';
import 'events.dart';
import 'home.dart';
import 'intro.dart';
import 'rooms.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Widget> pages = [    ProfilePage(),    RoomPage(),    Home(),    Events(),    AddEventPage(),  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text('Profile'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),

            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: Image.asset(
                  'assets/images/alu.png',
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                title: Text('ALU CAMPUS'),
                subtitle: Text(
                  user.email!,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: Container(
                  width: 24,
                  child: Icon(Icons.person, color: Colors.blueGrey[900]),
                ),
                title: Text(                    user.displayName ?? 'Unknown User'
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: Container(
                  width: 24,
                  child: IconButton(
                    icon: Icon(Icons.book, color: Colors.blueGrey[900]),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingsScreen()),
                    ),
                  ),
                ),
                title: Text('My Bookings'),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: Container(
                  width: 24,
                  child: Icon(Icons.help_center, color: Colors.blueGrey[900]),
                ),
                title: Text('Help'),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: Container(
                  width: 24,
                  child: IconButton(
                    icon: Icon(Icons.logout, color: Colors.blueGrey[900]),
                    onPressed: () {
                      FirebaseAuth.instance.signOut(); // Logging out from Firebase

                      // Navigating to a different page (replace 'HomePage' with your desired destination)
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => Intro()),
                      );
                    },
                  ),
                ),
                title: Text('Sign Out'),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),



      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8.0,
        onTap: (int index) {
          // Navigates to the corresponding page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pages[index]),
          );
        },
        selectedItemColor: Colors.grey,
        unselectedItemColor: Color(0xff022d42),
        selectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedLabelStyle: TextStyle(color: Color(0xff022d42)),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xff022d42)),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room_outlined),
            label: 'Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Event',
          ),
        ],
      ),


    );}}