import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:nursing_mother_medical_app/provider/firestore_provider.dart';
import '../config/firestore_constants.dart';
import '../model/model.dart';

class AppointmentProvider with ChangeNotifier {
  final FirestoreProvider firestoreProvider;

  AppointmentProvider({required this.firestoreProvider});

  Future<void> bookAppointment(Appointment appointment) async {
    await firestoreProvider.saveDocument(
      FirestoreConstants.pathAppointmentsCollection,
      appointment.id,
      appointment.toJson(),
    );
  }

  Stream<List<Appointment>> fetchAppointmentsForUser(String userId) {
    return firestoreProvider.firebaseFirestore
        .collection(FirestoreConstants.pathAppointmentsCollection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Appointment.fromDocument(doc)).toList());
  }

  Stream<List<Appointment>> fetchAppointmentsForProfessional(String professionalId) {
    return firestoreProvider.firebaseFirestore
        .collection(FirestoreConstants.pathAppointmentsCollection)
        .where('professionalId', isEqualTo: professionalId)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Appointment.fromDocument(doc)).toList());
  }
}
