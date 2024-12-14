import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServiceCart {
  final CollectionReference cartCollection =
  FirebaseFirestore.instance.collection('cart');

  Future<void> addCartItem({
    required String service,
    required String time,
    required String price,
  }) async {
    await cartCollection.add({
      'service': service,
      'time': time,
      'price': price,
      'timestamp': Timestamp.now(),
    });
  }

  Future<bool> checkTimeAvailability(String time) async {
    final snapshot = await cartCollection.where('time', isEqualTo: time).get();
    return snapshot.docs.isEmpty; // True jika waktu tersedia
  }
}