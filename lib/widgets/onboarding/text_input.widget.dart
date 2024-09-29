import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isLast;
  final TextInputType textInputType;
  final String? errorText;
  final bool readOnly;
  final int minLines;
  final int maxLines;
  final double? width;

  const TextInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isLast,
    this.errorText,
    this.minLines = 1,
    this.maxLines = 1,
    this.textInputType = TextInputType.emailAddress,
    this.readOnly = false,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        width: width,
        constraints: const BoxConstraints(maxWidth: 480),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          controller: controller,
          keyboardType: textInputType,
          obscureText: false,
          readOnly: readOnly,
          minLines: minLines,
          maxLines: max(1, max(minLines, maxLines)),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Colors.redAccent,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            filled: true,
            fillColor: const Color(0x45454545),
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            errorText: errorText,
            hintStyle: const TextStyle(color: Color(0xFF878787)),
          ),
          onEditingComplete: () {
            if (isLast) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
