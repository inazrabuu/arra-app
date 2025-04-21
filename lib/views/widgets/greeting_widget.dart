import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:flutter/material.dart';

class GreetingWidget extends StatelessWidget {
  static List<String> greetings = [
    AppStrings.greetingMorning,
    AppStrings.greetingNoon,
    AppStrings.greetingNight,
  ];

  const GreetingWidget({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;

    int index =
        hour >= 5 && hour < 12
            ? 0
            : hour >= 12 && hour < 18
            ? 1
            : 2;

    return greetings[index];
  }

  @override
  Widget build(BuildContext context) {
    return AppText.heading(_getGreeting());
  }
}
