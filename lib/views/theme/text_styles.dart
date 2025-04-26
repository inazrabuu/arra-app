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

  static Widget xtra(
    String text, {
    Color? color,
    String? fontFamily,
    double? letterSpacing,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: color ?? Colors.black,
        fontFamily: fontFamily ?? "SF Pro Display",
        letterSpacing: letterSpacing ?? 0,
      ),
    );
  }

  static Widget gridTitle(
    String text, {
    Color? color,
    String? fontFamily,
    double? letterSpacing,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: color ?? Colors.black,
        fontFamily: fontFamily ?? "SF Pro Display",
        letterSpacing: letterSpacing ?? 0,
      ),
    );
  }

  static Widget gridPrice(
    String text, {
    Color? color,
    String? fontFamily,
    double? letterSpacing,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: color ?? Colors.black,
        fontFamily: fontFamily ?? "SF Pro Display",
        letterSpacing: letterSpacing ?? 0,
      ),
    );
  }

  static Widget smallDate(String text, {Color? color}) {
    return Text(
      text,
      style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 12,
        color: color ?? Colors.black,
      ),
    );
  }
}
