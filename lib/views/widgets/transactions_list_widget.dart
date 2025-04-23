import 'package:arrajewelry/constants/candy_colors.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/pill_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        String formattedDate = DateFormat(
          'MMM d, y',
        ).format(items[index].trxDate);

        final idrFormat = NumberFormat.currency(
          locale: 'id_ID',
          symbol: 'Rp',
          decimalDigits: 0,
        );
        String total = idrFormat.format(items[index].total);

        List<Widget> pills = [];
        if (items[index].isPaid && items[index].isFulfilled) {
          pills.add(
            PillWidget(text: 'OK', color: CandyColors.colors['green']!),
          );
          pills.add(SizedBox(width: 4));
        } else {
          if (!items[index].isPaid) {
            pills.add(
              PillWidget(text: 'Unpaid', color: CandyColors.colors['blue']!),
            );
            pills.add(SizedBox(width: 4));
          }

          if (!items[index].isFulfilled) {
            pills.add(
              PillWidget(
                text: 'Unfulfilled',
                color: CandyColors.colors['purple']!,
              ),
            );
          }
        }

        Icon arrow =
            items[index].isDebit
                ? Icon(Icons.arrow_left_rounded, color: Colors.red)
                : Icon(Icons.arrow_right_rounded, color: Colors.green);
        return Card(
          // padding: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
                              AppText.bold('Trx #${items[index].orderNo}'),
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
                          Icon(
                            Icons.subdirectory_arrow_right_rounded,
                            size: 14,
                          ),
                          Text(items[index].description),
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
      },
    );
  }
}
