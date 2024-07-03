
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/features/professional/professional_detail_page.dart';

import '../config/app_colors.dart';
import '../config/app_strings.dart';
import '../reusables/data.dart';


class ProfessionalPageList extends StatelessWidget {
  const ProfessionalPageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text(
          AppStrings.professionalList,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,

        ),
        backgroundColor: AppColors.bgColor,
      ),
      body: ListView.builder(
        itemCount: professionalList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfessionalDetailPage(
                    professional: professionalList[index],
                  ),
                ),
              );
            },
            child:
            Container(
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
                      child: Image.asset(
                        professionalList[index]['image']!,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            professionalList[index]['name']!,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: AppColors.black),
                          ),
                          Text(
                            professionalList[index]['title']!,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: AppColors.black),
                          ),
                          Text(
                            professionalList[index]['description']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.greyTextColor,
                              fontWeight: FontWeight.w300
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            )
          );
        },
      ),
    );
  }
}

// NavigationService().navigateTo(
// AppRoutes.professionalDetail,
// arguments: professionalList[index],
// );
