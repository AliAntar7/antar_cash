import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String fieldName;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? inputType;
  final bool? obscureText;
  final String? Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.fieldName,
    required this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    required this.validator,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 0.08,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          onChanged: onChanged,
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText!,
          validator: validator,
          style: const TextStyle(
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
            fillColor: Colors.grey,
             border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 0.5, color: Colors.black),
            ),
            hintText: hintText,
            labelStyle: const TextStyle(
              color: Colors.white,
            ),
            prefixIcon: Icon(
              prefixIcon,
            ),
            suffixIcon: Icon(
              suffixIcon,
            ),
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
            ),
            prefixIconColor: Colors.white,
            suffixIconColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
