import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../model/appointment.dart';

class AppointmentList extends StatelessWidget {
  final List<Appointment> appointments;
  final bool isProfessional;

  const AppointmentList({
    super.key,
    required this.appointments,
    required this.isProfessional,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        final imageUrl = isProfessional
            ? appointment.userPhotoUrl
            : appointment.professionalPhotoUrl;

        return GestureDetector(
          onTap: () {
            // Add navigation to appointment detail page if needed
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
            child: Card(
              shadowColor: Colors.grey,
              color: Colors.white,
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        imageUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/nurse.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.firstName,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: AppColors.black),
                          ),
                          Text(
                            appointment.email,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: AppColors.black),
                          ),
                          Text(
                            appointment.reason,
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.greyTextColor,
                                fontWeight: FontWeight.w300),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${appointment.appointmentDate.toLocal()}',
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.greyTextColor,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
