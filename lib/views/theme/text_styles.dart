import 'package:flutter/material.dart';

class AppText {
  static Widget heading(String text, {Color? color}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color ?? Colors.black,
      ),
    );
  }
}
