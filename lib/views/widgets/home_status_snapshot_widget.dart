import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/views/widgets/status_badge_widget.dart';
import 'package:flutter/material.dart';

class HomeStatusSnapshotWidget extends StatelessWidget {
  const HomeStatusSnapshotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        children: [
          StatusBadgeWidget(title: '', text: '1.000.000', color: 2, size: 2),
          Row(
            children: [
              Expanded(
                child: StatusBadgeWidget(title: AppStrings.unpaid, text: '2'),
              ),
              Expanded(
                child: StatusBadgeWidget(
                  title: AppStrings.unfulfilled,
                  text: '2',
                  color: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
