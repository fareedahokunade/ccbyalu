import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final events = snapshot.data!.docs;

          if (events.isEmpty) {
            return Center(
              child: Text('No events found.'),
            );
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              final event = events[index].data() as Map<String, dynamic>;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.event),
                  title: Text(event['description']),
                  subtitle: Text('${event['location']} - ${event['room']}'),
                  trailing: Text(event['dateTime']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
