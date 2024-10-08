import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/features/login/login.dart';
import 'package:nursing_mother_medical_app/features/register/register.dart';

import '../../config/app_colors.dart';
import '../../config/app_strings.dart';
import '../../reusables/data.dart';
import '../../reusables/form/app_button.dart';
import '../../reusables/form/input_decoration.dart';

class SupportLibraryListItemPage extends StatelessWidget {
   const SupportLibraryListItemPage({super.key, required this.pageTitle, required this.pageDetail});

   final String pageTitle;
   final String pageDetail;

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
        backgroundColor: AppColors.bgColor,
      ),
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [

            SingleChildScrollView(child: Text(
              pageDetail,
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