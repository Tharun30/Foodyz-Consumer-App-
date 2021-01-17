import 'cartitems.dart';
import 'package:flutter/material.dart';

class CartDetails extends ChangeNotifier {
  List<CartItems> _items = [];
  String canteenUId = '';
  String canteenname = '';
  List<CartItems> get items {
    return [..._items];
  }

  List<String> _itemname = [];
  List<String> get name {
    // retrivenamedata();
    return [..._itemname];
  }

  List<int> _countNO = [];
  List<int> get countno {
    retrivecountdata();
    return [..._countNO];
  }

  String get canteenName {
    retrivenamedata();
    return _items[0].canteenname;
  }

  String get canteenuid {
    return _items[0].canteenid;
  }
  void cler(){
     _items.clear();
    _itemname.clear();
    canteenUId = '';
    canteenname = '';
    addTotal();
  }

  void retrivenamedata() {
     for (int i = 0; i < _items.length; i++) {
      _itemname.add('');
    }
    for (int i = 0; i < _items.length; i++) {
      _itemname[i] = _items[i].name;
    }
  }
  void retrivecountdata() {
    for (int i = 0; i < _items.length; i++) {
      _countNO.add(0);
    }
    for (int i = 0; i < _items.length; i++) {
      _countNO[i] = _items[i].count;
    }
  }

  void canteenUID(String uID, String canteenName) {
    canteenUId = uID;
    print(canteenname);
    canteenname = canteenName;
  }

  removeitems(BuildContext context, CartItems value) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Replae Cart Item?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Your cart contains dishes from  another $canteenname .Do you want to discard the selection and add dishes from this ${value.canteenname} ',
              style: TextStyle(
                letterSpacing: -1,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    replace(value, context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'YES',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // _showsnackbar();
                  },
                  child: Text(
                    'NO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          );
        });
  }

  void replace(CartItems value, BuildContext context) {
    _items.clear();
    _itemname.clear();
    canteenUId = '';
    canteenname = '';
    addItem(value, context);
  }

  int dup;
  void addItem(CartItems value, BuildContext context) {
    if (checksamecollge(value)) {
      if (checkItem(value)) {
        _items.add(value);
        // _itemname.add(value.canteenname);
        // _itemname.add(value.name);
      } else {
        dupitem(value);
      }
    } else {
      // return false;
      removeitems(context, value);
    }

    addTotal();
    notifyListeners();
    // return true;
  }

  bool checksamecollge(CartItems value) {
    if (_items.length == 0) {
      canteenUID(value.canteenid, value.canteenname);
      return true;
    } else {
      if (value.canteenid == canteenUId) {
        return true;
      } else
        return false;
    }
  }

  void dupitem(CartItems value) {
    int ip = _items[dup].count;
    ip = ip + value.count;
    _items[dup].count = ip;
    _items[dup].price = _items[dup].oprice * _items[dup].count;
  }

  bool checkItem(CartItems value) {
    int count = 0;
    for (int i = 0; i < items.length; i++) {
      if (_items[i].name == value.name) {
        count++;
        dup = i;
      }
    }
    if (count == 0) {
      return true;
    } else {
      return false;
    }
  }

  int _total1;
  void addTotal() {
    int _total = 0;
    for (int i = 0; i < items.length; i++) {
      _total = _total + _items[i].price;
    }
    _total1 = _total;
    notifyListeners();
  }

  void increaseItemCount(int i) {
    int ip = _items[i].count;
    ip++;
    _items[i].count = ip;
    _items[i].price = _items[i].oprice * _items[i].count;
    addTotal();
  }

  void decreaseItemCount(int i) {
    if (_items[i].count > 0) {
      int ip = _items[i].count;
      ip--;
      _items[i].count = ip;
      if (_items[i].count == 0) {
        _items.removeAt(i--);
        addTotal();
      }
      _items[i].price = _items[i].oprice * _items[i].count;
      addTotal();
    }
  }

  int get getTotal {
    if (_total1 == null) {
      return 0;
    } else
      return _total1;
  }
}
