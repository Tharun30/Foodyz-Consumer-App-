import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:startup_namer/cartitems.dart';
import 'cartdetails.dart';
import 'food.dart';
import 'cart.dart';
import 'package:provider/provider.dart';

class D extends StatefulWidget {
  final String todo;
  final FoodPass food;
  D({Key key, @required this.todo, @required this.food}) : super(key: key);

  @override
  _DState createState() => _DState(todo, food);
}

class _DState extends State<D> {
  int _counter = 0, _counter1 = 1;
  bool able = true;
  String todo;
  FoodPass food;
  _DState(this.todo, this.food);

  void _incrementCounter() {
    setState(() {
      if (_counter != 10) {
        _counter++;
      }
      if (_counter >= 1) {
        _counter1 = _counter;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      // print(_counter);
      if (_counter != 0) {
        _counter--;
      }
      if (_counter >= 1) {
        _counter1 = _counter;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.white,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                  tag: '$todo',
                  child: Center(
                    child: Image.network(
                      food.img,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Color(0xFF000000)),
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    food.fname.titleCase,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'From: ${food.canteename}'.titleCase,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9E9E9E)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    food.desc.sentenceCase,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff9E9E9E),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Rs ${(food.fprice * _counter1).toString()}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: _decrementCounter,
                                splashColor: Colors.blue,
                                highlightColor: Colors.blue,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border:
                                        Border.all(color: Color(0xFFFF6400)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Color(0xFFFF6400)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: Center(
                                    child: Text(
                                  '$_counter',
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.black),
                                )),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: _incrementCounter,
                                splashColor: Colors.blue,
                                highlightColor: Colors.blue,
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border:
                                        Border.all(color: Color(0xFF0FDB48)),
                                  ),
                                  child: Center(
                                    child: Text("+",
                                        style: TextStyle(
                                            fontSize: 33,
                                            color: Color(0xFF0FDB48))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'MAX 10',
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF0FDB48)),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AbsorbPointer(
        absorbing: _counter > 0 ? false : true,
        child: InkWell(
          splashColor: Color.fromRGBO(15, 219, 72, 0.69),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Cart()));
            Provider.of<CartDetails>(context, listen: false).addItem(
                CartItems(
                    count: _counter,
                    price: (food.fprice * _counter),
                    oprice: food.fprice,
                    imgPath: food.img,
                    name: food.fname,
                    canteenid: food.canteeid,
                    canteenname: food.canteename),
                context);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            width: width / 2.3,
            height: 57,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: _counter > 0 ? Color(0xFF0FDB48) : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Center(
                child: Text('Order Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold))),
          ),
        ),
      ),
    );
  }
}
