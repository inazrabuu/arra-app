import 'package:flutter/material.dart';

class TrxIndicator extends StatelessWidget {
  final String indicator;
  const TrxIndicator({super.key, this.indicator = 'ok'});

  @override
  Widget build(BuildContext context) {
    Color c =
        indicator == 'unpaid'
            ? Color(0xFF4CC9F0)
            : indicator == 'unfulfilled'
            ? Color(0xFF9B5DE5)
            : Color(0xFF70E6A1);

    return Icon(Icons.circle, color: c, size: 14);
  }
}
