import 'package:flutter/material.dart';
import '../features/messaging/group_chat_page.dart';
import '../features/professional/professional_detail_page.dart';

class AppRoutes {
  static const String professionalDetail = '/professionalDetail';
  static const String otherDetail = '/otherDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case professionalDetail:
        // final args = settings.arguments as Map<String, String>;
        // return MaterialPageRoute(
        //   builder: (_) => ProfessionalDetailPage(professional: args),
        // );
      // case otherDetail:
      //   final args = settings.arguments as Map<String, String>;
        // return MaterialPageRoute(
        //   builder: (_) => ProfessionalDetailPage(professional: args),
        // );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
