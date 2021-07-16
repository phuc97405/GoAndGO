import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goandgo/models/go.dart';
import 'package:goandgo/models/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  final CollectionReference goCollection =
      FirebaseFirestore.instance.collection('goandgo');

  Future updateUserData(String sugars, String name, int strength) async {
    return await goCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }
//go list from snaphot

  List<Go> _goListFromSnaphot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Go(
          name: doc['name'],
          strength: doc['strength'] ?? 0,
          sugars: doc['sugars'] ?? '0');
    }).toList();
  }

//userData from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return UserData(
        uid: uid,
        name: data['name'],
        sugars: data['sugars'],
        strength: data['strength']);
  }

//get go stream
  Stream<List<Go>> get go {
    return goCollection.snapshots().map(_goListFromSnaphot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return goCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
