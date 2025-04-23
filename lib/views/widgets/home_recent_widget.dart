import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/notifiers.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:arrajewelry/utils/helpers.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
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
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: AppText.bold("#${items[index].orderNo}")),
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
