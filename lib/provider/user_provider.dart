import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../config/constants.dart';
import '../model/user.dart';
import 'firestore_provider.dart';

class UserProvider with ChangeNotifier {
  final FirestoreProvider firestoreProvider;

  UserProvider({required this.firestoreProvider});

  Future<void> saveUserToFirestore(String uid, String firstName, String? imageUrl, String bio, String hcp, String email, String type) async {
    final result = await firestoreProvider.firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .where(FirestoreConstants.id, isEqualTo: uid)
        .get();
    final documents = result.docs;

    if (documents.isEmpty) {
      // Writing data to server because here is a new user
      await firestoreProvider.firebaseFirestore.collection(FirestoreConstants.pathUserCollection).doc(uid).set({
        FirestoreConstants.firstname: firstName,
        FirestoreConstants.photoUrl: imageUrl,
        FirestoreConstants.id: uid,
        FirestoreConstants.createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        FirestoreConstants.chattingWith: null,
        FirestoreConstants.bio: bio,
        FirestoreConstants.hcp: hcp,
        FirestoreConstants.email: email,
        FirestoreConstants.type: type,

      });

      // Write data to local storage
      await firestoreProvider.prefs.setString(FirestoreConstants.id, uid);
      await firestoreProvider.prefs.setString(FirestoreConstants.firstname, firstName);
      await firestoreProvider.prefs.setString(FirestoreConstants.photoUrl, imageUrl ?? "");
      await firestoreProvider.prefs.setString(FirestoreConstants.bio, bio ?? "");
      await firestoreProvider.prefs.setString(FirestoreConstants.email, email ?? "");
    }
  }

  Future<void> fetchUserFromFirestore(String uid) async {
    final document = await firestoreProvider.getDocument(FirestoreConstants.pathUserCollection, uid);

    if (document.exists) {
      // Write data to local storage
      await firestoreProvider.prefs.setString(FirestoreConstants.id, uid);
      await firestoreProvider.prefs.setString(FirestoreConstants.firstname, document.get(FirestoreConstants.firstname));
      await firestoreProvider.prefs.setString(FirestoreConstants.photoUrl, document.get(FirestoreConstants.photoUrl) ?? "");
      await firestoreProvider.prefs.setString(FirestoreConstants.bio, document.get(FirestoreConstants.bio) ?? "");
      await firestoreProvider.prefs.setString(FirestoreConstants.email, document.get(FirestoreConstants.email) ?? "");
    }
  }

  Future<List<User>> fetchProfessionals() async {
    QuerySnapshot snapshot = await firestoreProvider.firebaseFirestore
        .collection(FirestoreConstants.pathUserCollection)
        .where('type', isEqualTo: 'professional')
        .get();

    List<User> professionals = snapshot.docs.map((doc) {
      return User.fromDocument(doc);
    }).toList();

    return professionals;
  }
}
