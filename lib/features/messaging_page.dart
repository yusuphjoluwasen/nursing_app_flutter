import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/features/login/login_play.dart';
import 'package:nursing_mother_medical_app/features/register.dart';
import 'package:nursing_mother_medical_app/features/supportlibrary/support_library.dart';
import 'package:nursing_mother_medical_app/features/supportlibrary/support_library_list_item.dart';

import '../config/app_colors.dart';
import '../config/app_strings.dart';
import '../reusables/data.dart';
import '../reusables/form/app_button.dart';
import '../reusables/form/input_decoration.dart';
import 'chat_page.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text(
          AppStrings.messaging,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,

        ),
        backgroundColor: AppColors.bgColor,
      ),
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/images/messaging.png'),
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: buildInputDecoration(hintText: 'Search'),
              ),
              const SizedBox(height: 15),
              // Use Expanded to give the ListView a bounded height
               Expanded(
                child: SupportLibraryList(supportList: supportLibraryList,
                    pageBuilder: (context, item) {
                      return ChatPage(pageTitle: item['title']!);
                    })
              ),
            ],
          ),
        ),
      ),
    );
  }
}
