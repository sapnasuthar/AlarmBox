import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:alarm_box/views/home.dart';
import 'package:firebase_database/firebase_database.dart'; 
import '/pages/states.dart';

class CloseBoxPage extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  var isOpen;

  void updateDatabase() {
    _database.child('').update({'status': 'closed'});
  }

  @override
  Widget build(BuildContext context) {
    final boxRef = _database.child('box/');
    isOpen = boxRef.child("isOpen").get();
    return Scaffold(
      appBar: AppBar(
        title: Text('Close Lockbox'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              var isOpenSnapshot = await boxRef.child("isOpen").get();
              var isFullSnapshot = await boxRef.child("isFull").get();
              var isOpen = isOpenSnapshot.value;

              await boxRef.update({
                'isOpen': isOpen == 0 ? 1 : 0, 
              });
            } catch (e) {
              print(e);
            }
          },
          child: Text('Close Lockbox'),
        ),
      ),
    );
  }
}
