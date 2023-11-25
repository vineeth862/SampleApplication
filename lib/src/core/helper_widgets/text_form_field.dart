import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  InputBorder border;
  final IconData icon;
  final String errorMsg;
  final bool obscureText;
  Widget? suffixIcon;
  InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.errorMsg,
    this.border = const OutlineInputBorder(),
    required this.icon,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: label,
          border: border,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMsg;
        }
        return null;
      },
    );
  }
}
