import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Previousorders extends StatefulWidget {
  Previousorders({Key key}) : super(key: key);

  @override
  _PreviousordersState createState() => _PreviousordersState();
}

class _PreviousordersState extends State<Previousorders> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
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
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25.0,
                ),
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          'Previous orders',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('Corders')
              .where('userID', isEqualTo: user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final orders = snapshot.data.documents;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ListView(
                    children: List.generate(
                      orders.length,
                      (int index) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset(
                                      'assets/Group.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(orders[index]['canteenName'],
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            'Dayananada Sagar College Of Enginnering'),
                                      ],
                                    ),
                                  ),
                                  Spacer(
                                    flex: 10,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'ITEMS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ),
                              Column(
                                  children: List.generate(
                                orders[index].data['totalCount'],
                                (ind) => Text(
                                  " ${orders[index]['itemName'][ind]} * ${orders[index]['itemCount'][ind]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      'ORDERED ON',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                     orders[index]['orderTime'].toDate().toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'TOTAL AMOUNT',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      "\$ ${orders[index]['totalPrice']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.blue,
                                      // width: 3.0 --> you can set a custom width too!
                                    ),
                                    bottom: BorderSide(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              orders[index]['isDelivered']
                                  ? Text(
                                      'Delivered',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    )
                                  : Text(
                                      'Not Delivered',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          
              else if (!snapshot.hasData) {
                return Center(
                  child: Text(
                    'No orders yet',
                    style: TextStyle(color: Colors.white,fontSize: 50),
                  ),
                );
              }
            
            return Text('wait');
          }),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Previousorders extends StatefulWidget {
  Previousorders({Key key}) : super(key: key);

  @override
  _PreviousordersState createState() => _PreviousordersState();
}

class _PreviousordersState extends State<Previousorders> {
  final CollectionReference orderscoll =
      Firestore.instance.collection('orders');
  List<String> names = [];
  List<String> orders = ['the', 'orders', 'are', 'you', 'are', 'a', 'fool'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
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
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            'Previous orders',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        body: StreamBuilder(
            stream: orderscoll.where('userid', isEqualTo: '123').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('wait');

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ListView(
                    children: List.generate(
                      snapshot.data.documents.length,
                      (int index) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Container(
                                    height: 70,
                                    width: 70,

                                    // child: Image.asset(
                                    //   'assets/Group.png',
                                    //   fit: BoxFit.fill,
                                    // ),
                                  ),
                                  Spacer(
                                    flex: 2,
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('canteen name',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                        Text(snapshot.data.documents[1]
                                            ['orders'][index]),
                                      ],
                                    ),
                                  ),
                                  Spacer(
                                    flex: 10,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'ITEMS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ),
                              Column(
                                  children: List.generate(
                                snapshot.data.documents[index]['length'],
                                (ind) => Text(snapshot.data.documents[index]
                                    ['orders'][ind]),
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      'ORDERED ON',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      '22 JULY 2018 AT 09:00 AM',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'TOTAL AMOUNT',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    Text(
                                      '\$ 150',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}*/
