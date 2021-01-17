import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
// import 'package:startup_namer/screens/editprofile.dart';
// import 'package:startup_namer/search.dart';
// import 'package:startup_namer/services/datadownload.dart';
import 'cartdetails.dart';
import 'login.dart';
import "package:flare_flutter/flare_actor.dart";
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Make user stream available
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: ChangeNotifierProvider<CartDetails>(
        create: (context) => CartDetails(),
       
          child: MaterialApp(
            theme: ThemeData(
              primaryColor: Colors.white,
              fontFamily: 'Montserrat',
              backgroundColor: Color(0xFF0FDB48),
              brightness: Brightness.light,
            ),
            home: SplashScreen(),
          ),
        
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor(
        'assets/S2.flr',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "splash",
      ),
    );
  }
}
