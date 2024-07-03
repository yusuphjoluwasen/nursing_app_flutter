import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Navigate to a named route
  void navigateTo(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  // Navigate to a specific page
  void navigateToPage(Widget page) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Navigate to a page and clear all previous features
  void navigateToAndRemoveUntil(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
          (route) => false, // Remove all previous routes
      arguments: arguments,
    );
  }

  // Push a new route onto the navigator stack
  void push(Widget page) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Replace the current route with a new route
  void pushReplacement(Widget page) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Pop the current route off the navigator stack
  void pop() {
    navigatorKey.currentState?.pop();
  }

  // Pop to the root of the navigator stack
  void popToRoot() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  // Push a new route onto the navigator stack and clear the stack
  void pushAndRemoveUntil(Widget page) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
          (route) => false, // Remove all previous routes
    );
  }

  // Replace the current route and navigate to a new route
  void replace(Widget page) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Show a snackbar
  void showSnackbar(String message) {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  // Show an alert dialog
  Future<void> showAlertDialog({
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context != null) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            if (cancelText != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onCancel != null) onCancel();
                },
                child: Text(cancelText),
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) onConfirm();
              },
              child: Text(confirmText ?? 'OK'),
            ),
          ],
        ),
      );
    }
  }
}
