import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'notifications.dart';
import 'package:flutter/material.dart';




class NotificationsIcon extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('notifications').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          );
        }

        int newNotificationsCount = snapshot.data!.docs.where((doc) => !doc['read']).length;

        return Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // mark all notifications as read
                for (QueryDocumentSnapshot doc in snapshot.data!.docs) {
                  if (!doc['read']) {
                    doc.reference.update({'read': true});
                  }
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },
            ),

          ],
        );
      },
    );
  }
}
