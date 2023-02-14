// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFormComponent extends StatelessWidget {
  TextFormComponent(
      {super.key,
      required this.controller,
      this.voidCallback,
      required this.labelText,
      required this.keyboardType,
      required this.iconData,
      this.onTap,
      required this.isPassword});
  final TextEditingController? controller;
  String? Function(String?)? voidCallback;
  final bool isPassword;
  final String labelText;
  final TextInputType keyboardType;
  final IconData iconData;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      obscureText: isPassword,
      validator: voidCallback,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          prefixIcon: Icon(iconData)),
      style: TextStyle(fontSize: 15.0, color: Colors.black45),
    );
  }
}
