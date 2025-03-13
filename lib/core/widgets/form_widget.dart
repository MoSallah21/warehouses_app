import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final String? text;
  final TextEditingController controller;
  final TextInputType? inputType;
  final String label;
  final IconData? suffix;
  final Function(String)? onSub;
  final bool? textShow;
  final String? Function(String?)? validator;
  final String? initialText;
  final  Function(String)? onChanged;
  FormWidget({
    this.text,
    required this.controller,
    this.inputType,
    required this.label,
    this.suffix,
    this.onSub,
    this.textShow,
    this.validator,
    this.initialText,
    this.onChanged
  }) {
    if (controller.text.isEmpty) {
      controller.text = initialText ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onFieldSubmitted: (value) {
        if (onSub != null) {
          onSub!(value);
        }
      },
      keyboardType: inputType ?? TextInputType.name,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixText: text,
        labelText: label,
        suffixIcon: Icon(suffix),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      obscureText: textShow ?? false,
    );
  }
}
