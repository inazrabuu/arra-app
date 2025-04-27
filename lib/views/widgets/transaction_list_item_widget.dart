import 'package:arrajewelry/constants/candy_colors.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/pill_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListItemWidget extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionListItemWidget({super.key, required this.transaction});

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
    return Card(
      // padding: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                  child: Row(
                    children: [
                      Icon(Icons.subdirectory_arrow_right_rounded, size: 14),
                      Text(transaction.description),
                    ],
                  ),
                ),
                Expanded(
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
    );
  }
}
