import 'package:cloud_firestore/cloud_firestore.dart';
import 'rfood.dart';

class DatabaseService {
  var canteenCollection = Firestore.instance
      .collection('Canteen')
      .where('collegeName', isEqualTo: 'Dayananda Sagar College Of Engineering');

  List<Canteen> _canteenlistfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Canteen(
        canteenName: doc.data['canteenName'] ?? '',
        image: doc.data['image'] ?? '',
      );
    }).toList();
  }

  Stream<List<Canteen>> get canteen {
    return canteenCollection.snapshots().map(_canteenlistfromsnapshot);
  }

  // var canteenCategoriesCollection = Firestore.instance
  //     .collection('categories')
  //     .where('canteenName', isEqualTo: 'Canteen1');
// List<CanteenCategories> _canteencategorieslistfromsnapshot(
  //     QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return CanteenCategories(
  //       catagaryName: doc.data['item'] ?? '',
  //     );
  //   }).toList();
  // }
  // Stream<List<CanteenCategories>> get items {
  //   return canteenCategoriesCollection
  //       .snapshots()
  //       .map(_canteencategorieslistfromsnapshot);
  // }
}
