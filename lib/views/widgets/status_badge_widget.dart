import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:flutter/material.dart';

class StatusBadgeWidget extends StatelessWidget {
  final String title;
  final String text;
  final int color;
  static List<Color> colors = [Color(0xFF4CC9F0), Color(0xFF9B5DE5)];

  const StatusBadgeWidget({
    super.key,
    required this.title,
    required this.text,
    this.color = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colors[color],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(child: AppText.gridPrice(title, color: Colors.white)),
            Center(child: AppText.gridPrice(text, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
