import 'package:arrajewelry/constants/candy_colors.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:arrajewelry/views/pages/transaction_add_page.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/pill_widget.dart';
import 'package:arrajewelry/views/widgets/transaction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TransactionListItemWidget extends StatelessWidget {
  final TransactionModel transaction;
  final Function deleteData;

  const TransactionListItemWidget({
    super.key,
    required this.transaction,
    required this.deleteData,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM d, y').format(transaction.trxDate);

    final idrFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    String total = idrFormat.format(transaction.total);

    List<Widget> pills = [];
    if (transaction.isPaid && transaction.isFulfilled) {
      pills.add(PillWidget(text: 'OK', color: CandyColors.colors['green']!));
      pills.add(SizedBox(width: 4));
    } else {
      if (!transaction.isPaid) {
        pills.add(
          PillWidget(text: 'Unpaid', color: CandyColors.colors['blue']!),
        );
        pills.add(SizedBox(width: 4));
      }

      if (!transaction.isFulfilled) {
        pills.add(
          PillWidget(text: 'Unfulfilled', color: CandyColors.colors['purple']!),
        );
      }
    }

    Icon arrow =
        transaction.isDebit
            ? Icon(Icons.arrow_left_rounded, color: Colors.red)
            : Icon(Icons.arrow_right_rounded, color: Colors.green);
    return Slidable(
      key: ValueKey(transaction.id),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder:
                      (_, _, _) => TransactionAddPage(transaction: transaction),
                  transitionsBuilder: (context, animation, _, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit_rounded,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Confirm Delete.'),
                    content: Text(
                      'Delete transaction #${transaction.orderNo}?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          deleteData(transaction.id);
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_rounded,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        // padding: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: false, // if you want full screen
              builder:
                  (context) =>
                      TransactionDetailWidget(transaction: transaction),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              arrow,
                              AppText.bold('Trx #${transaction.orderNo}'),
                            ],
                          ),
                          AppText.smallDate(formattedDate),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [AppText.gridPrice(total)],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Icon(
                            Icons.subdirectory_arrow_right_rounded,
                            size: 14,
                          ),
                          Text(transaction.name),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: pills,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
