import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/firestore_constants.dart';
import 'providers.dart';

class Status {
  final StatusType type;
  final String? errorMessage;

  Status(this.type, {this.errorMessage = ''});

  static Status uninitialized = Status(StatusType.uninitialized);
  static Status authenticated = Status(StatusType.authenticated);
  static Status authenticating = Status(StatusType.authenticating);
  static Status authenticateCanceled = Status(StatusType.authenticateCanceled);

  static Status authenticateError(String errorMessage) {
    return Status(StatusType.authenticateError, errorMessage: errorMessage);
  }

  static Status authenticateException(String errorMessage) {
    return Status(StatusType.authenticateException, errorMessage: errorMessage);
  }
}

enum StatusType {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateException,
  authenticateCanceled,
}

class AuthProviders extends ChangeNotifier {
  final FirebaseAuth firebaseAuth;
  final UserProvider userProvider;
  final StorageProvider storageProvider;
  final SharedPreferences prefs;

  AuthProviders({
    required this.firebaseAuth,
    required this.userProvider,
    required this.storageProvider,
    required this.prefs,
  });

  Status _status = Status.uninitialized;

  Status get status => _status;

  String? get userFirebaseId => prefs.getString(FirestoreConstants.id);

  Future<bool> registerAndCreateUser(Signup register, File imageFile) async {
    //set loading to true
    _status = Status.authenticating;
    notifyListeners();

    // Save user picture to Firebase Storage
    final downloadUrl = await storageProvider.uploadImage(imageFile, register.firstname);

    if (downloadUrl == null) {
      print("Couldn't save image");
      _status = Status.authenticateError("Couldn't save image");
      notifyListeners();
      return false;
    }

    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: register.email,
          password: register.password // Add a password field in the Register model
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        print("Couldn't register user");
        _status = Status.authenticateError("Couldn't register user");
        notifyListeners();
        return false;
      }

      // Save user to Firestore
      await userProvider.saveUserToFirestore(firebaseUser.uid, register.firstname, downloadUrl, register.bio, register.hcp, register.email, register.userType);

      _status = Status.authenticated;
      notifyListeners();
      return true;

    } on FirebaseAuthException catch (e) {
      print('Registration error: $e');
      _status = Status.authenticateError(e.message ?? "Couldn't log in user");
      notifyListeners();
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    //set loading to true
    _status = Status.authenticating;
    notifyListeners();

    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        print("Couldn't log in user");
        _status = Status.authenticateCanceled;
        notifyListeners();
        return false;
      }

      // Retrieve user data from Firestore
      await userProvider.fetchUserFromFirestore(firebaseUser.uid);

      _status = Status.authenticated;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _status = Status.authenticateError(e.message ?? "Couldn't log in user");
      notifyListeners();
      return false;
    }
  }

  Future<void> forgotPassword(String email) async {
    _status = Status.authenticating;
    notifyListeners();

    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      _status = Status.authenticated;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _status = Status.authenticateError(e.message ?? "Couldn't send password reset email");
      notifyListeners();
    } catch (e) {
      _status = Status.authenticateException(e.toString());
      notifyListeners();
    }
  }

  void handleException(String error) {
    _status = Status.authenticateException(error);
    notifyListeners();
  }

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
  }
}
