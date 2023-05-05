import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';


class BookPage extends StatefulWidget {
  final String? selectedRoom;

  BookPage({this.selectedRoom});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  bool _loading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title = "";
  String _location = "ALU Hub";
  DateTime _dateTime = DateTime.now();
  String _selectedRoom = "";

  @override
  void initState() {
    super.initState();
    _selectedRoom = widget.selectedRoom ?? "";
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2021),
        lastDate: DateTime(2100));
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() {
        _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
            picked.hour, picked.minute);
      });
    }
  }

  void _submitForm() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      setState(() {
        _loading = true; // Set loading state to true
      });

      // Get the current user ID
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;

      try {
        final docRef =
        await FirebaseFirestore.instance.collection("bookings").add({});
        await docRef.update({
          "title": _title,
          "location": _location,
          "dateTime": _dateTime.toIso8601String(),
          "room": _selectedRoom,
          "userId": userId, // Add the user ID to the booking document
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Room booked successfully!")),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error booking room: $e")),
        );
      } finally {
        setState(() {
          _loading = false; // Set loading state to false
        });
      }
    }
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book room"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              TextFormField(
                decoration: InputDecoration(
                  labelText: "Reason",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title for the room';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Location",
                ),
                value: _location,
                onChanged: (value) {
                  setState(() {
                    _location = value!;
                  });
                },
                items: <String>['ALU Hub', 'ALU Campus']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a location';
                  }
                  return null;
                },
                onSaved: (value) {
                  _location = value!;
                },
              ),



          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "Room",
            ),
            value: _selectedRoom.isNotEmpty ? _selectedRoom : null,
            onChanged: (value) {
              setState(() {
                _selectedRoom = value!;
              });
            },
            items: rooms
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select a room';
              }
              return null;
            },
            onSaved: (value) {
              _selectedRoom = value!;
            },
          ),









          SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Date',
                          border: OutlineInputBorder(),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),

                      ),

                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectTime(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Time',),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${_dateTime.hour}:${_dateTime.minute.toString().padLeft(2, '0')}",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Book Rooom"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


