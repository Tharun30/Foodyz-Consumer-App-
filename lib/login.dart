import 'package:flutter/material.dart';

// import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'search.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String email;
  String password;
  Future loginin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 2;
    } catch (error) {
      return 1;
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showsnackbar() {
    final snackBar = new SnackBar(
      content: new Text('wrong email or password'),
      duration: new Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  final _formKey = GlobalKey<FormState>();
  String error = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // bool loading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: height / 4,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    height: (height / 2) + 10,
                    top: -110,
                    left: 0,
                    width: width + 40,
                    child: Container(
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage('assets/Group.png'),
                          // fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                // vertical: 10.0
              ),
              height: 3 * height / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ColorizeAnimatedTextKit(
//                    isRepeatingAnimation: false
                    totalRepeatCount: 2,
                    colors: [
                      Colors.black,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ],
                    text: ['Foody Z'],
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Pacifico',
                      letterSpacing: 1,
                      fontSize: 40.0,
                    ),
                  ),
                  TypewriterAnimatedTextKit(
                    speed: Duration(milliseconds: 200),
                    pause: Duration(milliseconds: 50),
                    totalRepeatCount: 1,
                    text: [
                      'Right Food At The Right Time',
                    ],
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: height / 15,
                  ),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: width / 1.25,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xcc000000),
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                  )
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.61),
                                            width: 1.0,
                                            style: BorderStyle.solid)),
                                  ),
                                  child: TextFormField(
                                    controller: _emailController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'EMAIL',
                                      hintStyle: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.61),
                                      ),
                                    ),
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter an email' : null,
                                    onChanged: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    textAlign: TextAlign.center,
                                    obscureText: true,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'PASSWORD',
                                      hintStyle: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 0.61),
                                      ),
                                    ),
                                    validator: (val) => val.length < 6
                                        ? 'Enter a password 6+ chars long'
                                        : null,
                                    onChanged: (val) {
                                      setState(() {
                                        password = val;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height / 15,
                          ),
                          InkWell(
                            splashColor: Color.fromRGBO(15, 219, 72, 0.69),
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                // setState(() => loading = true);
                                dynamic result = await loginin(email, password);
                                if (result == 1) {
                                  _showsnackbar();
                                }
                                if (result == null) {
                                  setState(() {
                                    // loading = false;
                                    error = 'Please supply a valid email';
                                  });
                                }
                                if (result == 2) {
                                  _emailController.clear();
                                  _passwordController.clear();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: width / 2,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Color(0xFF0FDB48),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Center(
                                  child: Text('LOGIN',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18))),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                          ),
                          SizedBox(
                            height: height / 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('New User ? ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUP()),
                                  );
                                },
                                child: Text('SIGNUP',
                                    style: TextStyle(
                                      color: Color(0xFF0FDB48),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
