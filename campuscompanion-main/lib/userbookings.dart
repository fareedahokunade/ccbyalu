
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile.dart';
import 'rooms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'addevent.dart';
import 'home.dart';
import 'events.dart';

// Define a class to represent a booking
class Booking {
  final String id;
  final String title;
  final String room;
  final String location;
  final DateTime dateTime;

  Booking({
    required this.id,
    required this.title,
    required this.room,
    required this.location,
    required this.dateTime,
  });
}

// Define a function to retrieve the bookings for the current user
Future<List<Booking>> getUserBookings() async {
  // Get the current user ID
  final user = FirebaseAuth.instance.currentUser!;
  final userId = user.uid;

  // Query the 'bookings' collection for the current user's bookings
  final querySnapshot = await FirebaseFirestore.instance
      .collection('bookings')
      .where('userId', isEqualTo: userId)
      .get();

  // Map the query results to a list of Booking objects
  final bookings = querySnapshot.docs.map((doc) {
    final data = doc.data();
    return Booking(
      id: doc.id,
      title: data['title'],
      room: data['room'],
      location: data['location'],
      dateTime: DateTime.parse(data['dateTime']),
    );
  }).toList();

  return bookings;
}

class BookingsScreen extends StatelessWidget {
  final List<Widget> pages = [    ProfilePage(),    RoomPage(),    Home(),    Events(),    AddEventPage(),  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: FutureBuilder<List<Booking>>(
            future: getUserBookings(),
            builder: (BuildContext context, AsyncSnapshot<List<Booking>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final booking = snapshot.data![index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            booking.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                            ),
                          ),
                          subtitle: Text(
                            '${booking.room} - ${booking.location}',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                            ),
                          ),
                          trailing: Text(
                            '${booking.dateTime.toString()}',
                            style: TextStyle(
                              color: Colors.blueGrey[600],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blueGrey[600]!,
                    ),
                  ),
                );
              }
            },
          ),
        ),
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

    );
  }
}
