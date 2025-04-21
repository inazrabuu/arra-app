import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/pill_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const TransactionListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
      itemBuilder: (context, index) {
        DateTime trxDate = DateTime.parse(items[index]['date']);
        String formattedDate = DateFormat('MMM d, y').format(trxDate);

        final idrFormat = NumberFormat.currency(
          locale: 'id_ID',
          symbol: 'Rp',
          decimalDigits: 0,
        );
        String total = idrFormat.format(items[index]['total']);

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
                          AppText.bold('Order #${items[index]['order_no']}'),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PillWidget(text: 'Unfulfilled', color: Color(0xFF9B5DE5)),
                    SizedBox(width: 4),
                    PillWidget(text: 'Unpaid', color: Color(0xFF4CC9F0)),
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
