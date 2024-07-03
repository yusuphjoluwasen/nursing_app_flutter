
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../reusables/form/app_button.dart';
import '../appointment/book_appointment.dart';

class ProfessionalDetailPage extends StatelessWidget {
  final Map<String, String> professional;

  const ProfessionalDetailPage({required this.professional, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Go back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child:  ClipOval(
              child: Image.asset(
                professional['image']!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            )),
            const SizedBox(height: 10),

            Text(
              professional['name']!,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.black),
            ),
            Text(
              professional['title']!,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 16),
            Text(
              professional['description']!,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.greyTextColor,
                  fontWeight: FontWeight.w300
              ),
            ),

            const SizedBox(height: 40),

            AppElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const BookAppointment(),
                    // const Register(userType: 'professional'),
                  ),
                );

              },
              buttonText: "Book Appointment",
            )
          ],
        ),
      ),
    );
  }
}
