import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/notifiers.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:arrajewelry/utils/helpers.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/trx_indicator.dart';
import 'package:flutter/material.dart';

class HomeRecentWidget extends StatelessWidget {
  final List<TransactionModel> items;
  const HomeRecentWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.heading2(AppStrings.homeRecent, color: Colors.grey[700]),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            Icon typeIcon =
                items[index].isDebit
                    ? Icon(Icons.arrow_left_rounded, color: Colors.red)
                    : Icon(Icons.arrow_right_rounded, color: Colors.green);

            List<Widget> orderNo = [
              typeIcon,
              AppText.bold("#${items[index].orderNo}"),
              SizedBox(width: 4),
            ];

            if (items[index].isPaid && items[index].isFulfilled) {
              orderNo.add(TrxIndicator());
            } else {
              if (!items[index].isPaid) {
                orderNo.add(TrxIndicator(indicator: 'unpaid'));
              }
              if (!items[index].isFulfilled) {
                orderNo.add(TrxIndicator(indicator: 'unfulfilled'));
              }
            }

            return Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xFFF0F5F6),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xCCCACDCE),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: Row(children: orderNo)),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppText.gridPrice(
                            Helpers.priceIdrFormat(items[index].total),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: selectedPageNotifier,
          builder: (context, value, _) {
            return GestureDetector(
              onTap: () {
                selectedPageNotifier.value = 2;
              },
              child: Center(child: Text(AppStrings.homeRecentAll)),
            );
          },
        ),
      ],
    );
  }
}
