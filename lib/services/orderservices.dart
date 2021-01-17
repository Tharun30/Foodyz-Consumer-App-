import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../cartitems.dart';

class OrderServices {
  storeOrder(
      {List<String> item,
      int price,
      List<int> count,
      String orderID,
      FirebaseUser user,
      String canteenUID,
      String canteenName,
      String payment,
      List<CartItems> s
      }) {
    List<String> item1 = [];
    List<int> count1 = [];
     for (int i = 0; i < s.length; i++) {
       item1.add(item[i]);
       count1.add(count[i]);
     }
 
    DocumentReference documentReference =
        Firestore.instance.collection('Corders').document(orderID);
    documentReference.setData({
      'orderTime': DateTime.now(),
      'itemName': item1,
      'totalPrice': price,
      'itemCount': count1,
      'totalCount': s.length,
      'orderID': orderID,
      'userID': user.uid,
      'canteenName': canteenName,
      'canteenUID': canteenUID,
      'paymentMethod': payment,
      'isDelivered': false
    });
  }
}
