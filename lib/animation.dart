import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/bill.dart';

class SplashScreens extends StatefulWidget {
  final String orderid;
  SplashScreens({this.orderid});
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Bill(
                  orderid: widget.orderid,
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor(
        'assets/tick.flr',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "Untitled",
      ),
    );
  }
}
