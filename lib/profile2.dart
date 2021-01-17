// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:palette_generator/palette_generator.dart';
import 'package:startup_namer/prevousorders.dart';
import 'package:startup_namer/services/profileservices.dart';
import 'package:startup_namer/services/profileuserdata.dart';
// import 'profile.dart';

class Profile2 extends StatelessWidget {
  Profile2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: StreamProvider.value(
          // All children will have access to weapons data
          catchError: (_, __) => null,
          value: DatabaseService().userData(user),
          child: Something()),
    );
  }
}

class Something extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var user = Provider.of<ProfileUserData>(context);

    return Stack(
      children: <Widget>[
        Image.network(user.image),
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              height: height,
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 28.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                    height: height / 2,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                Navigator.pop(context);
                              },
                              splashColor: Colors.blue,
                              highlightColor: Colors.blue,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFFF),
                                  borderRadius: BorderRadius.circular(100),
                                  // border: Border.all(
                                  //     width: 2, color: Color(0xFF000000)),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                    size: 28.0,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(flex: 1),
                            Text(
                              'PROFILE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                // fontFamily: 'Montserrat',
                                letterSpacing: 1,
                                // fontFamily: 'Sacramento-Regular',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(flex: 6),
                          ],
                        ),
                        Spacer(flex: 30),
                        Text(
                          user.userName.toUpperCase(),
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(flex: 1),
                        Text(
                          user.phoneNO,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(flex: 1),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(flex: 6),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                    height: height / 2,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(
                          flex: 3,
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Previousorders()),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 4,
                            color: Color(0xFFFfffff),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: width / 1.5,
                              child: Row(
                                children: <Widget>[
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Icon(
                                    Icons.folder,
                                    size: 30,
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text('ORDERS',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Spacer(
                                    flex: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => Previousorders()),
                            // );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 4,
                            color: Color(0xFFffffff),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: width / 1.5,
                              child: Row(
                                children: <Widget>[
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Icon(
                                    Icons.share,
                                    size: 30,
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text('SHARE',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Spacer(
                                    flex: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            _auth.signOut();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 4,
                            color: Color(0xFFffffff),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: width / 1.5,
                              child: Row(
                                children: <Widget>[
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Icon(
                                    Icons.exit_to_app,
                                    size: 30,
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text('LOG OUT',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Spacer(
                                    flex: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(flex: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
