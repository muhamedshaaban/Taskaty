import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField({
    super.key,
    required this.controller,
    required this.type,
    required this.validate,
    required this.label,
    required this.prefix,
    this.suffixPressed,
    this.onSubmit,
    this.onChange,
    this.onTap,
    this.suffix,
  });

  final TextEditingController controller;
  final TextInputType type;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final Function? suffixPressed;
  final String? Function(String?)? validate;

  final String label;
  final IconData prefix;
  final IconData? suffix;
  final bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon: Icon(suffix),
        labelText: label,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      obscureText: isPassword,
      validator: validate,
    );
  }
}
