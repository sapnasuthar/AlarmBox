import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '/pages/close_box.dart';

class States extends StatefulWidget {
  @override
  _States createState() => _States();
}

class _States extends State<States> {
  final database = FirebaseDatabase.instance.ref();

  //bool isButtonActive = false;
  bool isUserAuthentified = false;
  bool isBoxOpen = false;

  void onAuthenticationComplete(bool isAuthentified) {
    setState(() {
      isUserAuthentified = isAuthentified;
    });

    if (isBoxOpen) {
      //closeLockbox();
      Navigator.pushAndRemoveUntil(
      context,
        MaterialPageRoute(
          builder: (context) => CloseBoxPage(),
        ),
        (route) => false,
      );
    }
    else if (isUserAuthentified) {
      // Perform actions after successful authentication
      print('User is authenticated');
      openLockbox();
      Navigator.pushAndRemoveUntil(
      context,
        MaterialPageRoute(
          builder: (context) => CloseBoxPage(),
        ),
        (route) => false,
      );
    } else {
      // Handle unsuccessful authentication
      print('User is not authenticated');
    }
  }

  void openLockbox () async {
    final boxRef = database.child('box/');
    try {
      await boxRef
        .update({
          'isOpen': 1
        }
      );
      setState(() {
        isBoxOpen = true;
      });
    } catch (e) {
      print(e);
    }
  }
}