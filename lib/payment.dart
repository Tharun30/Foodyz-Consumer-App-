import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:startup_namer/cartdetails.dart';
import 'package:startup_namer/screens/paysome.dart';

import 'cartitems.dart';



class Payment extends StatefulWidget {
  final int ruppes;
  Payment({this.ruppes});
  @override
  _PaymentState createState() => _PaymentState();
}


class _PaymentState extends State<Payment> {
  int j = 1;
  // _PaymentState(rupees);
 

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    var f = Provider.of<CartDetails>(context);
    String canteenUID = f.canteenUId;
    String canteenName = f.canteenName;
    int price = f.getTotal;
    List<String> item = f.name;
    List<int> count = f.countno;
   List<CartItems> s=f.items;

    return PSomething(
        item: item,
        price: price,
        count: count,
        user: user,
        canteenUID: canteenUID,
        canteenName: canteenName,
        s:s
        );
  }
}
