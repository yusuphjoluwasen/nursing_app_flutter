import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';

InputDecoration buildInputDecoration({required String hintText, IconData? icon}) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border:  const OutlineInputBorder(),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.textFormOutline, width: 1.5),
    ),
    hintText: hintText,
    hintStyle: const TextStyle(fontSize: 14, color: AppColors.black),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary, width: 1.5),
    ),
      prefixIcon: icon != null ? Icon(icon, color: AppColors.black) : null,
      errorMaxLines: 3
  );
}