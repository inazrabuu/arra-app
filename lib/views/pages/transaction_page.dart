import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/dummies.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/status_badge_widget.dart';
import 'package:arrajewelry/views/widgets/transactions_list_widget.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatelessWidget {
  static final List<Map<String, dynamic>> items = DataDummies.transactions;

  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.heading(AppStrings.transactionPageTitle),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: StatusBadgeWidget(title: AppStrings.unpaid, text: '2'),
              ),
              Expanded(
                child: StatusBadgeWidget(
                  title: AppStrings.unfulfilled,
                  text: '5',
                  color: 1,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
            child: AppText.heading2(
              AppStrings.transactionPageHistory,
              color: Colors.grey[700],
            ),
          ),
          TransactionListWidget(items: items),
        ],
      ),
    );
  }
}
