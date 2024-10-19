import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool enabled;
  final String? Function(String)? onFieldSubmitted;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const NumberField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 0.5, color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 0.5, color: Colors.black),
        ),
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 0.5, color: Colors.black),
        ),
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        hintStyle: TextStyle(
          fontSize: 20,
          color: Colors.black.withOpacity(0.6),
        ),
        prefixIconColor: Colors.blue,
      ),
    );
  }
}
