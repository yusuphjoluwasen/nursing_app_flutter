
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/app_measurements.dart';
import 'button_style.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final double? width;
  final double? height;

  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? AppMeasurements.getScreenWidth(context), // Default to full screen width if not provided
      height: height ?? 45, // Default height if not provided
      child: ElevatedButton(
        onPressed: onPressed,
        style: elevatedButtonStyle(context),
        child: Text(buttonText),
      ),
    );
  }
}