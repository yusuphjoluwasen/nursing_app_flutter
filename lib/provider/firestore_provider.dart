import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';

class FirestoreProvider {
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;

  FirestoreProvider({
    required this.firebaseFirestore,
    required this.prefs,
  });

  Future<DocumentSnapshot> getDocument(String collectionName, String documentId) async {
    return await firebaseFirestore.collection(collectionName).doc(documentId).get();
  }

  Future<void> saveDocument(String collectionName, String documentId, Map<String, dynamic> data) async {
    await firebaseFirestore.collection(collectionName).doc(documentId).set(data);
  }

  Stream<QuerySnapshot> getRealTimeUpdates(String collectionName) {
    return firebaseFirestore.collection(collectionName).snapshots();
  }
}
