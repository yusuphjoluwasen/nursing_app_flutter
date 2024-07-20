import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageProvider extends ChangeNotifier {
  final FirebaseStorage firebaseStorage;

  StorageProvider({required this.firebaseStorage});

  Future<String?> uploadImage(File imageFile, String firstName) async {
    try {
      final storageRef = firebaseStorage.ref();
      final imageRef = storageRef.child('user_images/${firstName}_profile_picture.png');

      await imageRef.putFile(imageFile);

      // Get the download URL
      return await imageRef.getDownloadURL();
    } on FirebaseException catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
