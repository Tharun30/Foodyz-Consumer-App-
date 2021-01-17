// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({Key key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  int _value = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;
  void logout() {
    _auth.signOut();
     Future.delayed(Duration(milliseconds: 500), () {
         Navigator.pop(context);
     });
  
  }
  // Route _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => Cart(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       var begin = Offset(0.5, 1.0);
  //       var end = Offset.zero;
  //       var curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  // Route _createRoute2() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => Profile2(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       var begin = Offset(1.0, 0.0);
  //       var end = Offset.zero;
  //       var curve = Curves.easeOut;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  List<Card> _buildGridCards(int count) {
    List<Card> cards = List.generate(
      count,
      (int index) => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => D(
            //         todo: index.toString(),
            //       ),
            //     ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 18.0 / 11.0,
                child: Hero(
                  tag: '$index',
                  child: Image.asset(
                    'assets/food.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.pause_circle_outline,
                          size: 20,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Title',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "\$ 50",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget sideBarNav() {
      return SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: height / 2,
                width: 39 * width / 40,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(80)),
                  color: Color(0xFF000000),
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
                        // Navigator.of(context).push(_createRoute2());
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
                    GestureDetector(
                      onTap: () {
                        print('tap');
                        Navigator.of(context).pop();
                        logout();
                        // Navigator.pop(context);
                      },
                      child: Text(
                        'LOGOUT',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
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
      drawer: sideBarNav(),
      appBar: AppBar(
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_outline,
              size: 30,
            ),
            onPressed: () {
              // Navigator.of(context).push(_createRoute2());
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SingleChildScrollView(
                  child: Container(
                    height: height / 6,
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(8.0, 5.0, 6.0, 5),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Color(0xFFFF6400),
                                width: 5.0,
                                style: BorderStyle.solid),
                          ),
                          child: Image.asset(
                            'assets/profile.jpg',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color(0xffffffff),
                                  width: 5.0,
                                  style: BorderStyle.solid),
                            ),
                            child: Image.asset('assets/profile.jpg')),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color(0xffffffff),
                                  width: 5.0,
                                  style: BorderStyle.solid),
                            ),
                            child: Image.asset('assets/profile.jpg')),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color(0xffffffff),
                                  width: 5.0,
                                  style: BorderStyle.solid),
                            ),
                            child: Image.asset('assets/profile.jpg')),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Color(0xffffffff),
                                  width: 5.0,
                                  style: BorderStyle.solid),
                            ),
                            child: Image.asset('assets/profile.jpg')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SingleChildScrollView(
                  child: Container(
                    child: Wrap(
                      children: List<Widget>.generate(
                        4,
                        (int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            child: ChoiceChip(
                              elevation: 8,
                              pressElevation: 8,
                              selectedColor: Color(0xFFFF6400),
                              padding: EdgeInsets.all(10),
                              disabledColor: Colors.white,
                              shadowColor: Colors.black12,
                              label: Text('Item $index'),
                              selected: _value == index,
                              onSelected: (bool selected) {
                                setState(
                                  () {
                                    _value = selected ? index : null;
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: (height / 10) + 10, top: 1),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 8.0 / 9.0,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: _buildGridCards(10),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          // Navigator.of(context).push(_createRoute());
        },
        splashColor: Colors.blue,
        child: Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
//            color: Color(0xFF0FDB48),
            color: Colors.black,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
