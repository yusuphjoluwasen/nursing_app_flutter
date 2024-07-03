import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';


class OnboardingScreenNew extends StatefulWidget {
  const OnboardingScreenNew({super.key});

  @override
  State<OnboardingScreenNew> createState() => _OnboardingScreenNewState();
}

class _OnboardingScreenNewState extends State<OnboardingScreenNew> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.white,
          body:
      SafeArea(child:
      Padding(padding: const EdgeInsets.all(20), child:
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child:
           Row(mainAxisSize: MainAxisSize.min,children: [
             Text(
               'Support',
               style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.black),
             ),
             const SizedBox(width: 5),
              Text("Library",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),),
           ])
            ),
            const SizedBox(height: 30),
            const Center(child:Image(image: AssetImage('assets/images/supportlibrary.png'),width: 250,height: 250,)),
            const SizedBox(height: 30),
            Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                  child:
              Text(AppStrings.supportlibrarytextbody,
                  style:Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black),textAlign: TextAlign.center,)),
            ),
            const SizedBox(height: 100),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
              Expanded(child: GestureDetector(onTap: () {  },
              child: Text(AppStrings.skip,
                style:Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.black)))),
              Expanded(child: Text(AppStrings.skip,
                style:Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black),textAlign: TextAlign.center,)),
              Expanded(child: GestureDetector(onTap: () {  },
                  child: Text(AppStrings.next,
                      style:Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.black),textAlign: TextAlign.end)))
            ]),
          ]
      ),),
      )
    );
  }
}
