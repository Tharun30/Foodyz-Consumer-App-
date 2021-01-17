import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
// import 'package:startup_namer/cartitems.dart';
import 'package:startup_namer/payment.dart';

import 'cartdetails.dart';
import 'cartitemui.dart';
import 'profile2.dart';
// import 'package:startup_namer/profile2.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  // CartItems items;
  // _CartState(this.items);
  // void _incrementCounter() {
  //   setState(() {
  //     int count=items.count;
  //     if (items.count != 10) {
  //     count++;
  //     }
  //     items.count=count;
  //   });
  // }

  // void _decrementCounter() {
  //   setState(() {
  //     int _counter=items.count;
  //     if (_counter != 1) {
  //       _counter--;
  //     }
  //   });
  // }

  Route _createRoute2() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Profile2(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var f = Provider.of<CartDetails>(context);
    int total = f.getTotal;

    final String assetName = 'assets/d.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      color: Colors.amber,
    );
    Widget sideBarNav() {
      return SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: height / 2,
                width: width,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(80)),
                  color: Color(0xFF151515),
                ),
                child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      "Foody'z",
                      style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(_createRoute2());
                      },
                      splashColor: Colors.white,
                      highlightColor: Colors.black,
                      child: Text(
                        'MY PROFILE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        // Navigator.of(context).push(_createRoute());
                      },
                      splashColor: Colors.white,
                      highlightColor: Colors.black,
                      child: Text(
                        'CART',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text(
                      'LOGOUT',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      drawer: sideBarNav(),
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: new ImageIcon(AssetImage('assets/slanted_menu.png')),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        brightness: Brightness.light,
        title: Text(
          "Foody'z",
          style: TextStyle(fontFamily: 'Pacifico', fontSize: 30),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 8, right: 8, bottom: 12),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: <Widget>[
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        'CART',
                        style: TextStyle(
                          color: Colors.white,
                          // letterSpacing: 1,
                          fontSize: 25,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(
                        flex: 9,
                      ),
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
                            border: Border.all(color: Color(0xFF000000)),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment(0, 1),
                    child: f.items.length == 0 ? svg : F()),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.black,
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: 22,
                              color: Color.fromRGBO(255, 255, 255, 0.72)),
                        ),
                        Text(
                          '\$ $total',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        Spacer(),
                        if (total != 0) ...[
                          InkWell(
                            splashColor: Color.fromRGBO(15, 219, 72, 0.69),
                            onTap: () {
                              f.name;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Payment(
                                          ruppes: f.getTotal,
                                        )),
                              );
                            },
                            child: Container(
                              width: width / 2.3,
                              height: 50,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Color(0xFF0FDB48),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Center(
                                  child: Text('Order Now',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold))),
                            ),
                          )
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget cartItem(CartItems item) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       ClipRRect(
//         borderRadius: BorderRadius.circular(60),
//         child: Image.network(
//               item.imgPath,
//               height: 60,
//               width: 60,
//               fit: BoxFit.fill,
//             ) ??
//             CircleAvatar(backgroundColor:Colors.blue),
//       ),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             item.name,
//             style: TextStyle(color: Colors.white, fontSize: 18),
//           ),
//           Row(
//             children: <Widget>[
//               Text('*', style: TextStyle(color: Colors.white, fontSize: 18)),
//               Text(item.count.toString(),
//                   style: TextStyle(color: Colors.white, fontSize: 18)),
//             ],
//           )
//         ],
//       ),
//       Text(
//         item.price.toString(),
//         style: TextStyle(
//             color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//       Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Text('+',
//               style: TextStyle(
//                   color: Color(0xFF0FDB48),
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold)),
//           Text(
//             '-',
//             style: TextStyle(
//                 color: Color(0xFFFF6400),
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold),
//           ),
//         ],
//       )
//     ],
//   );
// }
