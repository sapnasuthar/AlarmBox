import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart'; 

class Home extends StatelessWidget {
  Home({super.key});
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xff003366),
                  const Color(0xff003366),
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 100), // Keeps the title 100 pixels from the top
                child: Center(
                  child: Text(
                    "AlarmBox",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80), // Add some space between the title and the buttons
              // Add your buttons here
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      var isClosedSnapshot = await database.child("isClosed").get();
                      var isFullSnapshot = await database.child("isFull").get();
                      var isClosed = isClosedSnapshot.value;

                      await database.update({
                        'isClosed': 0, 
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Open Box'),
                  style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  fixedSize: Size(300, 80),
                  textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  elevation: 15,
                  shadowColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 40), // Space between buttons
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      var isClosedSnapshot = await database.child("isClosed").get();
                      var isFullSnapshot = await database.child("isFull").get();
                      var isClosed = isClosedSnapshot.value;

                      await database.update({
                        'isClosed': 1, 
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Close Box'),
                  style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  fixedSize: Size(300, 80),
                  textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  elevation: 15,
                  shadowColor: Colors.white,
                ),
                ),
              ),
              // Add more buttons as needed
            ],
          ),
        ],
      ),
    );
  }
}