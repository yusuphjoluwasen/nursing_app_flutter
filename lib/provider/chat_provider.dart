import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../config/constants.dart';
import '../../model/model.dart';
import 'firestore_provider.dart';

class ChatProvider with ChangeNotifier {
  final FirestoreProvider firestoreProvider;
  final FirebaseStorage firebaseStorage;

  ChatProvider({
    required this.firestoreProvider,
    required this.firebaseStorage,
  });

  UploadTask uploadFile(File image, String fileName) {
    Reference reference = firebaseStorage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath, Map<String, dynamic> dataNeedUpdate) {
    return firestoreProvider.firebaseFirestore.collection(collectionPath).doc(docPath).update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getGroupChatStream(String channelId, int limit) {
    return firestoreProvider.firebaseFirestore
        .collection(FirestoreConstants.pathChannelCollection)
        .doc(channelId)
        .collection(FirestoreConstants.pathChatCollection)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  // One-to-One Chat Methods
  Stream<QuerySnapshot> getPrivateChatStream(String peerId, String currentUserId, int limit) {
    String chatId = getChatId(peerId, currentUserId);
    return firestoreProvider.firebaseFirestore
        .collection(FirestoreConstants.pathIndividualChatCollection)
        .doc(chatId)
        .collection(FirestoreConstants.pathChatCollection)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(String content, String type, String channelId) {
    final documentReference = firestoreProvider.firebaseFirestore
        .collection(FirestoreConstants.pathChannelCollection)
        .doc(channelId)
        .collection(FirestoreConstants.pathChatCollection)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    final messageChat = MessageChat(
      idFrom: getUserId()  ?? '',
      idTo: channelId, // In group chat, the recipient is the channel itself
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      type: type,
      photoUrl:  getPhotoUrl() ?? '',
    );

    firestoreProvider.firebaseFirestore.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }

  Future<void> createChannel(String channelName, String channelId) async {
    final documentReference = firestoreProvider.firebaseFirestore
        .collection(FirestoreConstants.pathChannelCollection)
        .doc(channelId);

    await documentReference.set({
      'title': channelName,
      'id': channelId,
      'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  Stream<QuerySnapshot> getChannelListStream() {
    return firestoreProvider.getRealTimeUpdates(FirestoreConstants.pathChannelCollection);
  }

  void sendPrivateMessage(String content, String type, String peerId, String currentUserId) {
    String chatId = getChatId(peerId, currentUserId);
    final documentReference = firestoreProvider.firebaseFirestore
        .collection(FirestoreConstants.pathIndividualChatCollection)
        .doc(chatId)
        .collection(FirestoreConstants.pathChatCollection)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    final messageChat = MessageChat(
      idFrom: currentUserId,
      idTo: peerId, // In one-to-one chat, the recipient is the peer
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      type: type,
      photoUrl: getPhotoUrl() ?? '',
    );

    firestoreProvider.firebaseFirestore.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }

  String getChatId(String peerId, String currentUserId) {
    return currentUserId.hashCode <= peerId.hashCode
        ? '$currentUserId-$peerId'
        : '$peerId-$currentUserId';
  }

  String? getPhotoUrl() {
    return firestoreProvider.prefs.getString(FirestoreConstants.photoUrl);
  }

  String? getUserId() {
    return firestoreProvider.prefs.getString(FirestoreConstants.id);
  }
}
