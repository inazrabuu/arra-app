import 'package:flutter/material.dart';

class AppText {
  static Widget small(String text) {
    return Text(text, style: TextStyle(fontSize: 12));
  }

  static Widget bold(String text) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.bold));
  }

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

  static Widget heading2(String text, {Color? color}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color ?? Colors.black,
      ),
    );
  }

  static Widget gridTitle(String text, {Color? color}) {
    return Text(text, style: TextStyle(fontSize: 16));
  }

  static Widget gridPrice(String text, {Color? color}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: color ?? Colors.black,
      ),
    );
  }
}
