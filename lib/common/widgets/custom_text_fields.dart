import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.validator,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  // validator function
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText ?? hintText,
        hintStyle: TextStyle(
          color: context.colorScheme.onPrimary,
        ),
        labelStyle: TextStyle(
          color: context.colorScheme.onPrimary,
        ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: context.colorScheme.secondaryContainer,
          ),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator ?? (value) => null,
    );
  }
}
