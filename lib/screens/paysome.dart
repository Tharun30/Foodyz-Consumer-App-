import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
import 'package:startup_namer/animation.dart';
import 'dart:convert';
import 'dart:math';
// import 'animation.dart';
import 'package:startup_namer/services/orderservices.dart';

// import '../cartdetails.dart';
import '../cartitems.dart';
class Utils {
  final Random _random = Random.secure();

  String createCryptoRandomString([int length = 10]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }
}

class PSomething extends StatefulWidget {
  const PSomething({
    Key key,
   
    @required this.item,
    @required this.price,
    @required this.count,
    @required this.user,
    @required this.canteenUID,
    @required this.canteenName,
   @required this.s
  }) : super(key: key);

 final List<CartItems> s;
  final List<String> item;
  final int price;
  final List<int> count;
  final FirebaseUser user;
  final String canteenUID;
  final String canteenName;

  @override
  _PSomethingState createState() => _PSomethingState();
}

class _PSomethingState extends State<PSomething> {
  String payment = '';

   bool but1 = false, but2 = false, but3 = false, but4 = false, order = true;
  void _turnON(int i) {
    switch (i) {
      case 1:
        setState(() {
          if (but1 != true) {
            but1 = true;
            but2 = false;
            but3 = false;
            but4 = false;
            payment = 'Paytm';
          } else {
            but1 = false;
            but2 = false;
            but3 = false;
            but4 = false;
            payment = '';
          }
        });

        break;
      case 2:
        setState(() {
          if (but2 != true) {
            but2 = true;
            but1 = false;
            but3 = false;
            but4 = false;
            payment = 'Google Pay';
          } else {
            but2 = false;
            but1 = false;
            but3 = false;
            but4 = false;
            payment = '';
          }
        });
        break;
      case 3:
        setState(() {
          if (but3 != true) {
            but3 = true;
            but2 = false;
            but1 = false;
            but4 = false;
            payment = 'Amazon Pay';
          } else {
            but3 = false;
            but2 = false;
            but1 = false;
            but4 = false;
            payment = '';
          }
        });

        break;
      case 4:
        setState(() {
          if (but4 != true) {
            but4 = true;
            but2 = false;
            but3 = false;
            but1 = false;
            payment = 'Phonepe';
          } else {
            but4 = false;
            but2 = false;
            but3 = false;
            but1 = false;
            payment = '';
          }
        });
        break;
      default:
        setState(() {
          but4 = true;
          but2 = false;
          but3 = false;
          but1 = false;
        });
    }

    setState(() {
      if (but1 || but2 || but3 || but4)
        order = false;
      else
        order = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    // var f = Provider.of<CartDetails>(context);

    final String assetName = 'assets/image.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      height: 60.0,
      width: 45,
    );
    final String assetName1 = 'assets/gpay.svg';
    final Widget svg1 = SvgPicture.asset(
      assetName1,
      height: 28.0,
      width: 18,
    );
    final String assetName2 = 'assets/amazonpay.svg';
    final Widget svg2 = SvgPicture.asset(
      assetName2,
      height: 55.0,
      color: Colors.white,
      width: 45,
    );
    final String assetName4 = 'assets/phonepe.svg';
    final Widget svg4 = SvgPicture.asset(
      assetName4,
      height: 40.0,
    );
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 28.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              )),
              height: height / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF6400),

                            borderRadius: BorderRadius.circular(100),
                            // border: Border.all(
                            //     width: 2, color: Color(0xFF000000)),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 28.0,
                            ),
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      Text(
                        'PAYMENT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          // letterSpacing: 1,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(flex: 6),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'To Pay  Rs  ${widget.price}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _turnON(1);
                          // print(Utils().createCryptoRandomString());
                        },
                        child: Container(
                          height: 65,
                          decoration: BoxDecoration(
                            color: but1 ? Color(0xFF1C1C1C) : Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              svg,
                              Text(
                                'Paytm',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _turnON(2);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: but2 ? Color(0xFF1C1C1C) : Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              svg1,
                              Text(
                                'Google Pay',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _turnON(3);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: but3 ? Color(0xFF1C1C1C) : Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              svg2,
                              Text(
                                'Amazon pay',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _turnON(4);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: but4 ? Color(0xFF1C1C1C) : Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              svg4,
                              Text(
                                'Phonepe',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AbsorbPointer(
        absorbing:order,
        child: InkWell(
          splashColor: Color.fromRGBO(15, 219, 72, 0.69),
          onTap: () {
          String  orderid=Utils().createCryptoRandomString();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SplashScreens(orderid:orderid)));
            OrderServices().storeOrder(
                item: widget.item,
                price: widget.price,
                count: widget.count,
                orderID:orderid,
                user: widget.user,
                canteenUID: widget.canteenUID,
                canteenName: widget.canteenName,
                payment:payment,
                s:widget.s);
          },
          child: Container(
            width: width / 2.3,
            height: 57,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: order ? Colors.black : Color(0xFF0FDB48),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Center(
                child: Text('Proceed',
                    style: TextStyle(
                        color:order ? Colors.black : Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold))),
          ),
        ),
      ),
    );
  }
}
