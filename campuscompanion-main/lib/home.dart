import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'addevent.dart';
import 'event.dart';
import 'notificationstracking.dart';
import 'profile.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'events.dart';
import 'notifications.dart';
import 'rooms.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Widget> pages = [    ProfilePage(),    RoomPage(),    Home(),    Events(),    AddEventPage(),  ];
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    String? _photoUrl;


    Future<String?> uploadImageToFirebase(File imageFile, String fileName) async {
      try {
        Reference ref =
        FirebaseStorage.instance.ref().child('profilePictures/$fileName');
        UploadTask uploadTask = ref.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        return downloadUrl;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
    Future<Map<String, dynamic>> getUpcomingEvent() async {
      final now = DateTime.now();
      final snapshot = await FirebaseFirestore.instance
          .collection('events')
          .where('dateTime', isGreaterThanOrEqualTo: now)
          .orderBy('dateTime')
          .limit(1)
          .get();

      final event = snapshot.docs.first.data() as Map<String, dynamic>;
      return event;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      child:Center(
          child:
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/images/img_ellipse756_157x375.png',
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 160,
                  child: Text(
                    'Welcome',
                    textAlign: TextAlign.center,
                    style: TextStyle(shadows: [
                      Shadow(
                        color: Colors.blueGrey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ], color: Colors.white, fontFamily: 'Cabin', fontSize: 15.0),
                  ),
                ),
                Positioned(
                  top: 115,
                  left: 160,
                  child: Text(
                    user.displayName ?? 'Unknown User',

                    textAlign: TextAlign.center,
                    style: TextStyle(shadows: [
                      Shadow(
                        color: Colors.blueGrey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ], color: Colors.white, fontFamily: 'Cabin', fontSize: 15.0),
                  ),
                ),



                Center(
                  child: Stack(children: [


                    CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.white,
                      backgroundImage: _photoUrl == null
                          ? AssetImage("assets/images/img_journalism1.png")
                      as ImageProvider<Object>?
                          : NetworkImage(_photoUrl!)
                      as ImageProvider<Object>?,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.transparent,
                          ),
                          color: Colors.transparent,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            // Open file picker to select an image
                            final pickedFile = await ImagePicker()
                                .getImage(source: ImageSource.gallery);

                            if (pickedFile != null) {
                              // Upload the selected image to Firebase Storage
                              final fileName =
                              path.basename(pickedFile!.path);

                              final file = File(pickedFile.path);
                              final downloadUrl =
                              await uploadImageToFirebase(
                                  file, fileName);

                              // Update the photoUrl field in Firestore for the current user
                              final uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              await _firestore
                                  .collection('users')
                                  .doc(uid)
                                  .update({'photoUrl': downloadUrl});

                              // Update the UI with the new photo
                              setState(() {
                                _photoUrl = downloadUrl;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ]),
                ),

            Positioned(
                top: 30,
                right: 20,
                child:             NotificationsIcon(),
            ),
          ]),
          Container(
            width: 200,
            alignment: Alignment.center,
            child: Text(
              'Book a pod with ease',
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
                  fontSize: 25.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Color(0xffbeddec), // Set the background color
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(
                          20) // Make the container circular
                      ),
                  // Handle button press

                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookPage(selectedRoom: '',)),
                      );
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white, // Set the background color
                              shape: BoxShape
                                  .circle, // Make the container circular
                            ),
                            child: Image.asset(
                              "assets/images/img_icons8door481.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                          Text(
                            "Book a room",
                            style: TextStyle(
                                fontFamily: 'Cabin',
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                  )),
              Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Color(0xffbeddec), // Set the background color
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(
                          20) // Make the container circular
                      ),
                  // Handle button press
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddEventPage()),
                      );
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white, // Set the background color
                              shape: BoxShape
                                  .circle, // Make the container circular
                            ),
                            child: Image.asset(
                              "assets/images/img_icons8tearoffcalendar48.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                          Text(
                            "Add an Event",
                            style: TextStyle(
                                fontFamily: 'Cabin',
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                  )),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 100,
            alignment: Alignment.centerLeft,
            child: Text(
              'Events',
              textAlign: TextAlign.left,
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
                  fontSize: 25.0),
            ),
          ),
              Card(
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/img_kisspngchinab.png',
                  ),
                  title: Text('Fireside Chat '),
                  subtitle: Text('Burundi Room, ALU'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Events()),
                    );
                  },
                ),
              ),

              SizedBox(height: 100),
        ],
      ))),

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
