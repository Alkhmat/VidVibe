import 'package:flutter/material.dart';

class CustomTextFieled extends StatelessWidget {
  final String? label;
  final bool obscureText;
  final Widget? suffixIcon;
  final Icon? icon;
  final TextEditingController? controller;
  const CustomTextFieled(
      {super.key,
      required this.obscureText,
      this.icon,
      this.label,
      this.controller,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            fontStyle: FontStyle.normal,
            color: Colors.black),
        decoration: InputDecoration(
          label: Text(label.toString()),
          prefixIcon: icon,
          suffixIcon: suffixIcon,
          prefixIconColor: Colors.black,
          labelStyle: const TextStyle(
              fontSize: 18, fontStyle: FontStyle.normal, color: Colors.black),
        ),
      ),
    );
  }
}
