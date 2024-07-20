import 'package:cloud_firestore/cloud_firestore.dart';

class MessageChat {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  String type;
  String photoUrl;

  MessageChat({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'content': content,
      'type': type,
      'photoUrl': photoUrl,
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get('idFrom');
    String idTo = doc.get('idTo');
    String timestamp = doc.get('timestamp');
    String content = doc.get('content');
    String type = doc.get('type');
    String photoUrl = doc.get('photoUrl');
    return MessageChat(
      idFrom: idFrom,
      idTo: idTo,
      timestamp: timestamp,
      content: content,
      type: type,
      photoUrl: photoUrl,
    );
  }
}
