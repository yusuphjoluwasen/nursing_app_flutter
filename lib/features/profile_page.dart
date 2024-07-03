import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/features/supportlibrary/support_library.dart';

import '../config/app_colors.dart';
import '../config/app_strings.dart';
import '../reusables/data.dart';
import 'profile/my_appointment_page.dart';


class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text(
          AppStrings.profile,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,

        ),
        backgroundColor: AppColors.bgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const  Center(child:
            ClipOval(
              child: Image(
                image: AssetImage('assets/images/profile_pic.png'),
                width: 100,
                height: 100,
              ),
            )
            ),
            const SizedBox(height: 16),
            Center(child:  Text(
              "Nadya Bantu",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.black),
              textAlign: TextAlign.center,

            )),
            const SizedBox(height: 10),

            Center(child:  Text(
              "nadyabanti@gmail.com",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.black, decoration: TextDecoration.underline),
              textAlign: TextAlign.center,

            )),

            const SizedBox(height: 15),

            Center(child:  Text(
              "This first week is actually your menstrual period Because your expected birth date..",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.black),
              textAlign: TextAlign.center,

            )),

            const SizedBox(height: 15),
            // Use Expanded to give the ListView a bounded height
            GestureDetector(child:
            CardItem(cardItem: const {
              'title': 'My Appointments',
              'image': 'assets/images/messaging_item_icon.png',
            }), onTap: () => {
            Navigator.push(
            context, MaterialPageRoute(
            builder: (context) => const MyAppointmentPage(),
            ),
            )
            }),

            const SizedBox(height: 5),
            // Use Expanded to give the ListView a bounded height
            GestureDetector(child:
            CardItem(cardItem: const {
              'title': 'Suggest Chat Topic',
              'image': 'assets/images/messaging_item_icon.png',
            }), onTap: () => { })
          ],
        ),
      ),
    );
  }
}
