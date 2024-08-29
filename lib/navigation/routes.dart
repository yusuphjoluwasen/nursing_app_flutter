import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/features/login/forgot_pasword.dart';
import 'package:nursing_mother_medical_app/features/onboarding/onboarding_view.dart';
import 'package:nursing_mother_medical_app/features/onboarding/welcome.dart';

import '../features/login/login.dart';
import '../features/register/register.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const Login());
      case register:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => Register(userType: args?['userType'] ?? 'parent'),
        );
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

