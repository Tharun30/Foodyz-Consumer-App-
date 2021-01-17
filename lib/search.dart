import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animations/loading_animations.dart';
// import 'package:startup_namer/main%20-%20Copy.dart';
import 'package:startup_namer/profile2.dart';
import 'package:startup_namer/ssearch.dart';
import 'package:startup_namer/services/rfood.dart';
import 'package:startup_namer/services/datadownload.dart';
import 'package:provider/provider.dart';
import 'food.dart';
import 'cart.dart';
import 'd.dart';
// import 'profile2.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller = ScrollController();
  bool rBool = false;
  bool isSelected = true;
  bool isInternetON = false;
  IconData s = Icons.search;
  int _value;
  String canteenuid = '';
  String collegeName = '';
  String categaryName = '';

  int _value1 = 0;
  List<bool> array = [];
  falseArray1(int len, int val) {
    for (int i = 0; i < len; i++) {
      if (val != i) {
        setState(() {
          array[i] = false;
        });
      } else {
        setState(() {
          array[val] = true;
        });
      }
    }
  }

  int count = 1;
  falseArray(int len) {
    if (count == 1) {
      for (int i = 0; i < len; i++) {
        array.add(false);
      }
      count++;
    }
  }

  @override
  void initState() {
    super.initState();
    loop();
  }

  @override
  void dispose() {
    super.dispose();
    if (this.mounted) {
      checkInternetConnectivity();
      loop();
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Cart(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.5, 1.0);
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

  static String assetName = 'assets/veg.svg';
  Widget veg = SvgPicture.asset(
    assetName,
    width: 12,
    height: 12,
  );
  static String assetName2 = 'assets/nonveg.svg';
  Widget nonVeg = SvgPicture.asset(
    assetName2,
    width: 12,
    height: 12,
  );
  checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    // print(result);
    if (result == ConnectivityResult.none) {
      if (this.mounted) {
        setState(() {
          isInternetON = false;
        });
      }
    } else if (result == ConnectivityResult.mobile) {
      if (this.mounted) {
        setState(() {
          isInternetON = true;
        });
      }
    } else if (result == ConnectivityResult.wifi) {
      if (this.mounted) {
        setState(() {
          isInternetON = true;
        });
      }
    }
  }

  void loop() {
    Future.delayed(Duration(milliseconds: 10), () {
      if (this.mounted) {
        checkInternetConnectivity();
        loop();
      }
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final String svgNet = 'assets/net.svg';
    final Widget net = SvgPicture.asset(
      svgNet,
      height: height,
      width: width,
    );

    void logout() {
      _auth.signOut();
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pop(context);
      });
    }

    Widget sidenavbar() {
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
                         Navigator.push(context,MaterialPageRoute(builder: (c)=>Profile2()));
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
                        Navigator.of(context).push(_createRoute());
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
                        // print('tap');
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

    return StreamProvider<List<Canteen>>.value(
      value: DatabaseService().canteen,
      child: Scaffold(
        // backgroundColor: Colors.white,
        drawer: sidenavbar(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => AbsorbPointer(
              absorbing: !isInternetON,
              child: IconButton(
                icon: new ImageIcon(
                  AssetImage('assets/slanted_menu.png'),
                  size: 50,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          brightness: Brightness.light,
          title: Text(
            "Foody'z",
            style: TextStyle(fontFamily: 'Pacifico', fontSize: 30),
          ),
          centerTitle: true,
          actions: <Widget>[
            AbsorbPointer(
              absorbing: !isInternetON,
              child: IconButton(
                icon: Icon(
                  s,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage1()));
                  // setState(() {
                  //   this.isSelected ? s = Icons.close : s = Icons.search;
                  //   this.isSelected = !this.isSelected;
                  // });
                },
              ),
            ),
            AbsorbPointer(
              absorbing: !isInternetON,
              child: IconButton(
                  icon: Icon(
                    Icons.person_outline,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile2()));
                  }),
            ),
          ],
        ),
        body: isInternetON
            ? CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            child: SingleChildScrollView(
                              child: Row(children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePage1()));
                                  },
                                ),
                                Text(
                                  'dayananda sagar college of enginnerring'
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                            )),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SingleChildScrollView(
                          child: Container(
                            height: height / 8,
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection('Canteen')
                                    .where('collegeName',
                                        isEqualTo:
                                            'Dayananda Sagar College Of Engineering')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final names = snapshot.data.documents;
                                    int len = snapshot.data.documents.length;
                                    falseArray(len);
                                    return ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: List.generate(
                                        len,
                                        (int index) => GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                _value1 = _value1 != index
                                                    ? index
                                                    : null;
                                                canteenuid = names[_value1]
                                                    .data['canteenUID'];
                                                // _value = 0;
                                                // selected=true;
                                                falseArray1(len, _value1);
                                                // canteenName = names[_value1]
                                                //     .data['canteenID'];
                                                print(names[_value1]
                                                    .data['canteenUID']);
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                6, 0, 0, 0),
                                            child: Column(
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: AnimatedContainer(
                                                    duration: Duration(
                                                        milliseconds: 200),
                                                    width: width / 4.7,
                                                    height: width / 4.7,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            color: array[index]
                                                                ? Color(
                                                                    0xFFFF6400)
                                                                : Colors.white,
                                                            width: 6)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                      child: Image.network(
                                                        names[index]
                                                            .data['image'],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  names[index]
                                                      .data['canteenName']
                                                      .toString()
                                                      .headerCase,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Text('loading');
                                }),
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
                            height: height / 16,
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection('category')
                                    .where('canteenUID', isEqualTo: canteenuid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final items = snapshot.data.documents;
                                    return ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: List<Widget>.generate(
                                        snapshot.data.documents.length,
                                        (int index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 2),
                                            child: ChoiceChip(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              selectedColor: Color(0xFFFF6400),
                                              padding: EdgeInsets.all(10),
                                              backgroundColor: Colors.white,
                                              // disabledColor: Colors.white,
                                              shadowColor: Colors.black12,
                                              label: Text(
                                                  items[index]
                                                      .data['categoryName']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'Montserrat')),
                                              selected: _value == index,
                                              onSelected: (bool selected) {
                                                setState(
                                                  () {
                                                    _value =
                                                        selected ? index : null;
                                                    categaryName = selected
                                                        ? items[_value].data[
                                                            'categoryName']
                                                        : '';
                                                  },
                                                );
                                                print(items[_value]
                                                    .data['categoryName']);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    );

                                    // return Text('data');

                                  }
                                  return LoadingBouncingLine.circle();
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                      stream: Firestore.instance
                          .collection('food')
                          .where('canteenUID', isEqualTo: canteenuid)
                          .where('category', isEqualTo: categaryName)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(canteenuid);
                          print(categaryName);

                          final foods = snapshot.data.documents;
                          print(foods.length);
                         
                          return SliverPadding(
                            padding: EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                bottom: (height / 10) + 10,
                                top: 1),
                            sliver: SliverGrid.count(
                              crossAxisCount: 2,
                              childAspectRatio: 8.0 / 9.0,
                              mainAxisSpacing: 13,
                              crossAxisSpacing: 13,
                              children: List.generate(
                                snapshot.data.documents.length,
                                (int index) => Card(
                                  color: !foods[index].data['isAvailable']
                                      ? Colors.black.withOpacity(0.3)
                                      : Colors.white,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: InkWell(
                                    onTap: () {
                                      foods[index].data['isAvailable']
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => D(
                                                  todo: index.toString(),
                                                  food: FoodPass(
                                                    foods[index]
                                                        .data['foodName'],
                                                    foods[index].data['price'],
                                                    foods[index]
                                                        .data['frating'],
                                                    foods[index].data['image'],
                                                    foods[index].data['isVeg'],
                                                    foods[index]
                                                        .data['canteenUID'],
                                                    foods[index]
                                                        .data['canteenName'],
                                                    foods[index]
                                                        .data['description'],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    Color(0xFFFF6400),
                                                content: Row(
                                                  children: <Widget>[
                                                    Text('😞  '),
                                                    Text(
                                                      foods[index]
                                                          .data['foodName'],
                                                    ),
                                                    Text("  Unavilable")
                                                  ],
                                                ),
                                              ),
                                            );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        AspectRatio(
                                          aspectRatio: 18.0 / 12.0,
                                          child: Hero(
                                            tag: '$index',
                                            child: Image.network(
                                              foods[index].data['image'],
                                              fit: BoxFit.fill,
                                              color: !foods[index]
                                                      .data['isAvailable']
                                                  ? Colors.black
                                                      .withOpacity(0.3)
                                                  : Colors.transparent,
                                              colorBlendMode: BlendMode.darken,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              16.0, 12.0, 16.0, 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  if (foods[index]
                                                      .data['isVeg']) ...[veg],
                                                  if (!foods[index]
                                                      .data['isVeg']) ...[
                                                    nonVeg
                                                  ],
                                                  Spacer(),
                                                  Text(
                                                    foods[index]
                                                        .data['foodName']
                                                        .toString()
                                                        .titleCase,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                              SizedBox(height: 8.0),
                                              Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Text(
                                                    "Rs ${foods[index].data['price'].toString()}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                ),
                              ),
                            ),
                          );
                        }
                        return SliverList(
                            delegate: SliverChildListDelegate([
                          LoadingBouncingGrid.circle(
                            backgroundColor: Color(0xFFFF6400),
                            size: width / 2,
                            inverted: true,
                          )
                        ]));
                      })
                ],
              )
            : net,
        floatingActionButton: AbsorbPointer(
          absorbing: !isInternetON,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(_createRoute());

              // print(s);
            },
            splashColor: Colors.blue,
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
//            color: Color(0xFF0FDB48),
                color: isInternetON ? Colors.black : Colors.white,
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
        ),
      ),
    );
  }
}
