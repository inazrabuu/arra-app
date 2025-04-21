import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:flutter/material.dart';

class StatusBadgeWidget extends StatelessWidget {
  final String title;
  final String text;
  final int color;
  final int size;
  static List<Color> colors = [
    Color(0xFF4CC9F0),
    Color(0xFF9B5DE5),
    Color(0xFF70E6A1),
    Color(0xFFFF3C38),
  ];

  const StatusBadgeWidget({
    super.key,
    required this.title,
    required this.text,
    this.color = 0,
    this.size = 1,
  });

  List<Widget> _generateChildren() {
    List<Widget> children = [];

    Color c = Colors.white;

    if (title != '') {
      Widget titleWidget =
          size == 1
              ? AppText.gridPrice(title, color: c)
              : AppText.xtra(title, color: c);

      children.add(Center(child: titleWidget));
    }

    if (text != '') {
      Widget textWidget =
          size == 1
              ? AppText.gridPrice(text, color: c)
              : AppText.xtra(text, color: c);

      children.add(Center(child: textWidget));
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colors[color],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: _generateChildren()),
      ),
    );
  }
}
