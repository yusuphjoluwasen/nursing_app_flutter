import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/reusables/LoadingView.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_strings.dart';
import '../../model/appointment.dart';
import '../../provider/appointment_provider.dart';
import '../../config/firestore_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../reusables/appointment_list.dart';


class MyAppointmentPage extends StatefulWidget {
  const MyAppointmentPage({super.key});

  @override
  State<MyAppointmentPage> createState() => _MyAppointmentPageState();
}

class _MyAppointmentPageState extends State<MyAppointmentPage> {
  late Future<String?> _futureUserId;

  @override
  void initState() {
    super.initState();
    _futureUserId = getUserId();
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(FirestoreConstants.id);
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.my_appointments,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        backgroundColor: AppColors.bgColor,
      ),
      body: FutureBuilder<String?>(
        future: _futureUserId,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingView());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final userId = snapshot.data!;

          return StreamBuilder<List<Appointment>>(
            stream: appointmentProvider.fetchAppointmentsForUser(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: LoadingView());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No appointments found'));
              }

              return AppointmentList(
                appointments: snapshot.data!,
                isProfessional: false,
              );
            },
          );
        },
      ),
    );
  }
}
