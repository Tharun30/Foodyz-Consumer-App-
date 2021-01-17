import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../login.dart';

class UserManagement {
  storeNewUser(var user, context, String username, String phoneNo, String img) {
    //add user data
    Firestore.instance.collection('Consumers').document(user.uid).setData({
      'userEmail': user.email,
      'userUID': user.uid,
      'phoneNo': phoneNo,
      'userName': username,
      'userImage': img,
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => MyHomePage()));
    }).catchError((e) {
      print(e);
    });
  }
}
