import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String userId;
  final String professionalId;
  final String firstName;
  final String email;
  final DateTime appointmentDate;
  final String reason;
  final String userPhotoUrl;
  final String professionalPhotoUrl;

  Appointment({
    required this.id,
    required this.userId,
    required this.professionalId,
    required this.firstName,
    required this.email,
    required this.appointmentDate,
    required this.reason,
    required this.userPhotoUrl,
    required this.professionalPhotoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'professionalId': professionalId,
      'firstName': firstName,
      'email': email,
      'appointmentDate': appointmentDate.toIso8601String(),
      'reason': reason,
      'userPhotoUrl': userPhotoUrl,
      'professionalPhotoUrl': professionalPhotoUrl,
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String,
      userId: json['userId'] as String,
      professionalId: json['professionalId'] as String,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      reason: json['reason'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String,
      professionalPhotoUrl: json['professionalPhotoUrl'] as String,
    );
  }

  factory Appointment.fromDocument(DocumentSnapshot doc) {
    return Appointment.fromJson(doc.data() as Map<String, dynamic>);
  }
}
