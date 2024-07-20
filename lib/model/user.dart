import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String title;
  final String description;
  final String photoUrl;
  final String type;

  User({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.photoUrl,
    required this.type,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      name: doc['name'],
      title: doc['title'],
      description: doc['description'],
      photoUrl: doc['photoUrl'],
      type: doc['type'],
    );
  }
}
