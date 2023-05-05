import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notifications {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getEventsStream() {
    // Create a reference to the "events" collection in Firestore
    CollectionReference eventsRef = _firestore.collection('events');

    // Return a stream that listens to changes in the "events" collection
    return eventsRef.snapshots();
  }
}

class NotificationsPage extends StatelessWidget {
  final Notifications notifications = Notifications();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blueGrey, // Updated theme color
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: notifications.getEventsStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<QueryDocumentSnapshot> events = snapshot.data!.docs;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> eventData = events[index].data() as Map<String, dynamic>;
              String description = eventData['description'];
              String location = eventData['location'];


              return Card( // Wrapped ListTile in a Card for a neater look
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Text('New event created:', style: TextStyle(fontWeight: FontWeight.bold)),
                  title: Text(description),
                  subtitle: Text('$location'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
