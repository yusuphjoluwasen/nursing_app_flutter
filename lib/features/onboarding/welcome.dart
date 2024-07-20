import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/features/login/login_play.dart';
import 'package:nursing_mother_medical_app/features/register/register.dart';

import '../../config/app_colors.dart';
import '../../config/app_strings.dart';
import '../../reusables/form/app_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 100),
        margin: const EdgeInsets.all(20),child: Column(children: [
        Text(
          AppStrings.welcome,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.black),textAlign: TextAlign.center,
        ),

        const SizedBox(height: 30),

        Text(
          AppStrings.signUpInstruction,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.black),textAlign: TextAlign.center,
        ),

        const SizedBox(height: 60),

        AppElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>   const Register(userType: 'parent')
              ),
            );
          },
          buttonText: AppStrings.parents,
          width: 183,
        ),

        const SizedBox(height: 60),

        AppElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>   const Register(userType: 'professional')
              ),
            );
          },
          buttonText: AppStrings.professional,
          width: 183,
          height: 50,
        ),

        const SizedBox(height: 60),

        GestureDetector(onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPlay(),
            ),
          );
        },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style:Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.black)),
                const SizedBox(
                  width: 5,
                ),
                Text("Login",
                    style:Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primary))
              ],)),
      ],))
    );
  }
}
