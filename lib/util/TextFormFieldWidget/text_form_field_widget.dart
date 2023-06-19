import 'package:flutter/material.dart';

import '../../core/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    required this.labelText,
    required this.keyboardType,
    required this.controller,
     this.validator,
    this.obscureText = false,
    this.onPressed,
    this.icon,
  });
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  String? Function(String?)? validator;
  void Function()? onPressed;
  Icon? icon;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: colorWhite),
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: onPressed,
          child: icon ?? const SizedBox(),
        ),
        label: Text(
          labelText,
          style: const TextStyle(color: colorWhite),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: authbuttoncolor),
            borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: authbuttoncolor),
            borderRadius: BorderRadius.circular(20)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: authbuttoncolor),
            borderRadius: BorderRadius.circular(20)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(20)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
