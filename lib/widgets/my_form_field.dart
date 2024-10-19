import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final IconData prefixIcon;
  bool? obscureText;
  final String? Function(String)? onChanged;
  final String? Function(String?)? validator;
  MyFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.label,
    required this.prefixIcon,
    required this.validator,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText!,
      validator: validator,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.2),
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
        hintText: hintText,
        label: Text(label),
        labelStyle: const TextStyle(
          color: Colors.blue,
        ),
        prefixIcon: Icon(
          prefixIcon,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIconColor: Colors.blue,
      ),
    );
  }
}