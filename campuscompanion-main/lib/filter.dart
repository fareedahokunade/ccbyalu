import 'rooms.dart';
import 'package:flutter/material.dart';
import 'addevent.dart';
import 'events.dart';
import 'home.dart';
import 'profile.dart';
import 'rooms.dart';

class FilterPage extends StatefulWidget {
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final List<Widget> pages = [
    ProfilePage(),
    RoomPage(),
    Home(),
    Events(),
    AddEventPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff022d42),
        title: Text(
          'Booking Filters',
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start Date and Time',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select a date and time',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Duration',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Radio(value: true, groupValue: true, onChanged: null),
                Text('15 mins'),
              ],
            ),
            Row(
              children: [
                Radio(value: false, groupValue: true, onChanged: null),
                Text('30 mins'),
              ],
            ),
            Row(
              children: [
                Radio(value: false, groupValue: true, onChanged: null),
                Text('45 mins'),
              ],
            ),
            Row(
              children: [
                Radio(value: false, groupValue: true, onChanged: null),
                Text('1 hour'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Locations',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Radio(value: true, groupValue: true, onChanged: null),
                Text('ALU CAMPUS'),
              ],
            ),
            Row(
              children: [
                Radio(value: false, groupValue: true, onChanged: null),
                Text('ALU HUBS'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Attendees',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Radio(value: true, groupValue: true, onChanged: null),
                Text('0-3'),
              ],
            ),
            Row(
              children: [
                Radio(value: false, groupValue: true, onChanged: null),
                Text('4-7'),
              ],
            ),
            Row(
              children: [
                Radio(value: false, groupValue: true, onChanged: null),
                Text('8-10'),
              ],
            ),
            Row(
              children: [
                Radio(value: false, groupValue: true, onChanged: null),
                Text('>10'),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Apply'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff022d42),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          // Navigates to the corresponding page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pages[index]),
          );
        },
        selectedItemColor: Color(0xff022d42),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Color(0xff022d42)),
        unselectedLabelStyle: TextStyle(color: Colors.blueGrey),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xff022d42)),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room, color: Color(0xff022d42)),
            label: 'Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xff022d42)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event, color: Color(0xff022d42)),
            label: 'View Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Color(0xff022d42)),
            label: 'Add Events',
          ),
        ],
      ),
    );
  }
}
