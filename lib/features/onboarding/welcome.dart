import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/provider/providers.dart';
import 'package:nursing_mother_medical_app/navigation/routes.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_strings.dart';
import '../../reusables/form/app_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the NavigatorService
    final navigator = Provider.of<NavigationProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 100),
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              AppStrings.welcome,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              AppStrings.signUpInstruction,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            AppElevatedButton(
              onPressed: () {
                navigator.navigateTo(
                  AppRoutes.register,
                  arguments: {'userType': 'parent'},
                );
              },
              buttonText: AppStrings.parents,
              width: 183,
            ),
            const SizedBox(height: 60),
            AppElevatedButton(
              onPressed: () {
                navigator.navigateTo(
                  AppRoutes.register,
                  arguments: {'userType': 'professional'},
                );
              },
              buttonText: AppStrings.professional,
              width: 183,
              height: 50,
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                navigator.replaceWith(AppRoutes.login);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppColors.black)),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("Login",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppColors.primary))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
