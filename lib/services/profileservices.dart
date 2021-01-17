import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:startup_namer/services/profileuserdata.dart';

class DatabaseService {
  // collection reference
  final CollectionReference datacollection1 =
      Firestore.instance.collection('Consumers');

  ProfileUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return ProfileUserData(
      email: snapshot.data['userEmail'] ?? '',
      userName: snapshot.data['userName'] ?? '',
      phoneNO: snapshot.data['phoneNo'] ?? '',
      image: 'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg'??
          'https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg',
    );
  }

  Stream<ProfileUserData> userData(FirebaseUser user) {
    return datacollection1
        .document(user.uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
