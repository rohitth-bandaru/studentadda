import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  getLocationBasedData(String location, int choice) {
    if (choice == 0) {
      return FirebaseFirestore.instance
          .collection('rooms')
          .where('city', isEqualTo: location)
          .snapshots();
    } else if (choice == 1) {
      return FirebaseFirestore.instance
          .collection('rooms')
          .where('city', isEqualTo: location)
          .where('type', isEqualTo: true)
          .snapshots();
    }
    return FirebaseFirestore.instance
        .collection('rooms')
        .where('city', isEqualTo: location)
        .where('type', isEqualTo: false)
        .snapshots();
  }
}
