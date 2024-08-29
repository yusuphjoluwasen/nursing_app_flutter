import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String firstname;
  final String hcp;
  final String bio;
  final String photoUrl;
  final String type;

  User({
    required this.id,
    required this.firstname,
    required this.hcp,
    required this.bio,
    required this.photoUrl,
    required this.type,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      firstname: doc['firstname'],
      hcp: doc['hcp'],
      bio: doc['bio'],
      photoUrl: doc['photoUrl'],
      type: doc['type'],
    );
  }
}
