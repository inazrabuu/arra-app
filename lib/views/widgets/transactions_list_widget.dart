import 'package:arrajewelry/models/transaction_model.dart';
import 'package:arrajewelry/views/widgets/transaction_list_item_widget.dart';
import 'package:flutter/material.dart';

class TransactionListWidget extends StatelessWidget {
  final List<TransactionModel> items;

  const TransactionListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      itemBuilder: (context, index) {
        return TransactionListItemWidget(transaction: items[index]);
      },
    );
  }
}
