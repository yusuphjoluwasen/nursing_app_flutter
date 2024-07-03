import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/features/login/login_play.dart';
import 'package:nursing_mother_medical_app/features/register.dart';
import 'package:nursing_mother_medical_app/features/report.dart';

import '../config/app_colors.dart';
import '../config/app_strings.dart';
import '../reusables/data.dart';
import '../reusables/form/app_button.dart';
import '../reusables/form/input_decoration.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.pageTitle});

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          pageTitle,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Go back to the previous page
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),  // More icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const  ReportPage(),
                  // const Register(userType: 'professional'),
                ),
              );

            },
          ),
        ],
        backgroundColor: AppColors.bgColor,
      ),
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [

              SingleChildScrollView(child: Text(
                "first week is actually your menstrual period Because your expected birth date (EDD or EDB) is calculated from the first day of your last period.",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppColors.greyTextColor),
                textAlign: TextAlign.left,
              ))
            ],)
        ),
      ),
    );
  }
}