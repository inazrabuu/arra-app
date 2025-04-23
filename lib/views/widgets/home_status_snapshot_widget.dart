import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/utils/helpers.dart';
import 'package:arrajewelry/views/widgets/status_badge_widget.dart';
import 'package:flutter/material.dart';

class HomeStatusSnapshotWidget extends StatelessWidget {
  final double balance;
  final int unpaid;
  final int unfulfilled;

  const HomeStatusSnapshotWidget({
    super.key,
    required this.balance,
    required this.unpaid,
    required this.unfulfilled,
  });

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
          StatusBadgeWidget(
            title: '',
            text: Helpers.numberFormat(balance),
            color: 2,
            size: 2,
          ),
          Row(
            children: [
              Expanded(
                child: StatusBadgeWidget(
                  title: AppStrings.unpaid,
                  text: Helpers.numberFormat(unpaid.toDouble()),
                ),
              ),
              Expanded(
                child: StatusBadgeWidget(
                  title: AppStrings.unfulfilled,
                  text: Helpers.numberFormat(unfulfilled.toDouble()),
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
