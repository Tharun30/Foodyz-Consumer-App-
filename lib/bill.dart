import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/cartdetails.dart';

import 'cartitems.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Bill extends StatefulWidget {
  final String orderid;
  Bill({Key key, this.orderid}) : super(key: key);
  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {
  // _BillState(this.j);
  // var time = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String assetName1 = 'assets/bill.svg';
    // var f = Provider.of<CartDetails>(context);
    CartDetails f = Provider.of<CartDetails>(context);
    List<CartItems> item = f.items;
    int len = item.length;
    final sizes = MediaQuery.of(context).size;
    final Widget svg1 = SvgPicture.asset(
      assetName1,
      height: sizes.height / 1.2,
      color: Color(0xffFCD612),
      // width: sizes.width,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            f.cler();
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.done_all,
                    color: Color(0xff0FDB48),
                    size: 44,
                  ),
                  Text('PAYMENT SUCCESSFUL'),
                ],
              ),
            ),
            // Center(
            //     child: Text(
            //   '$j:$i',
            //   style: TextStyle(fontSize: 25),
            // )),
            Center(child: svg1),
            Center(
              child: Container(
                width: sizes.width / 1.5,
                height: sizes.height / 1.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Order No : ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${widget.orderid}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(flex: 1),
                    Text(
                      'Order Time : ',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${DateTime.now()}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Items',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Column(
                      children: List.generate(
                        len,
                        (int index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              item[index].name,
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              item[index].price.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(flex: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total :',
                          style: TextStyle(
                            color: Color(0xff0FDB48),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        //  '${(progressPercent * 100).toStringAsFixed(2)} %',
                        Text(
                          '\$ ${f.getTotal.toString()}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0FDB48),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
