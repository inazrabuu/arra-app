import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/dummies.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:arrajewelry/services/transaction_service.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/status_badge_widget.dart';
import 'package:arrajewelry/views/widgets/transactions_list_widget.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  static final List<Map<String, dynamic>> items = DataDummies.transactions;

  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TransactionService transactionService = TransactionService();
  List<TransactionModel> _transactions = [];
  int _unpaid = 0;
  int _unfulfilled = 0;

  @override
  initState() {
    super.initState();
    countUns();
    loadTransactions();
  }

  loadTransactions() async {
    final data = await transactionService.fetchAll();
    setState(() => _transactions = data);
  }

  countUns() async {
    int cp = await transactionService.countUns('paid');
    int cf = await transactionService.countUns('fulfilled');
    setState(() {
      _unpaid = cp;
      _unfulfilled = cf;
    });
  }

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
                child: StatusBadgeWidget(
                  title: AppStrings.unpaid,
                  text: _unpaid.toString(),
                ),
              ),
              Expanded(
                child: StatusBadgeWidget(
                  title: AppStrings.unfulfilled,
                  text: _unfulfilled.toString(),
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
          TransactionListWidget(items: TransactionPage.items),
        ],
      ),
    );
  }
}
