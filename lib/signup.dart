import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:startup_namer/home2.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:startup_namer/screens/signup2.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUP extends StatefulWidget {
  SignUP({Key key}) : super(key: key);

  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String email, password;
  String error = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 2;
    } catch (error) {
      if (error is PlatformException) {
        if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          return 1;
        }
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _showsnackbar() {
    final snackBar = new SnackBar(
      content: new Text('email already exist'),
      duration: new Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double sBox, sFontSize, lFontSize;
    if (height < 600 && width < 370) {
      sBox = 10;
      sFontSize = 16;
      lFontSize = 30.0;
    } else {
      sBox = height / 20;
      sFontSize = 18;
      lFontSize = 40.0;
    }
    // AuthResult signedInUser;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          // valueColor: Tw
          backgroundColor: Color(0xFF0FDB48),
        ),
        inAsyncCall: loading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: height / 4,
              child: Stack(children: <Widget>[
                Positioned(
                  height: (height / 2.3),
                  top: -105,
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
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
              ),
              height: 3 * height / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Foody Z',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Pacifico',
                      letterSpacing: 1,
                      fontSize: lFontSize,
                    ),
                  ),
                  Text(
                    'Right Food At The Right Time',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sFontSize,
                    ),
                  ),
                  SizedBox(
                    height: height / 15,
                  ),
                  Form(
                    key: _formKey,
                    child: Center(
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
                              _emailController.clear();
                              _passwordController.clear();
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await registerWithEmailAndPassword(
                                        email, password);
                                if (result == 1) {
                                  loading = false;
                                  _showsnackbar();
                                }
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'Please supply a valid email';
                                  });
                                }
                                if (result == 2) {
                                  // Navigator.pop(context);
                                    loading = false;

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signin2()),
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: width / 2.5,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0xFF0FDB48),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Center(
                                  child: Text('SIGNUP',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18))),
                            ),
                          ),
                         
                          SizedBox(
                            height: sBox,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Already Have An Account? ',
                                  style: TextStyle(
                                      fontSize: sFontSize,
                                      fontWeight: FontWeight.w500)),
                              GestureDetector(
                                onTap: () {
                                  print(height);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()),
                                  );
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Color(0xFF0FDB48),
                                    fontSize: sFontSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
