import 'package:arrajewelry/data/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/dummies.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/greeting_widget.dart';
import 'package:arrajewelry/views/widgets/status_badge_widget.dart';

class HomePage extends StatelessWidget {
  static List<Map<String, dynamic>> products = DataDummies.products;
  static List<Map<String, dynamic>> transactions = DataDummies.transactions;

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreetingWidget(),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: Column(
              children: [
                StatusBadgeWidget(
                  title: '',
                  text: '1.000.000',
                  color: 2,
                  size: 2,
                ),
                Row(
                  children: [
                    Expanded(
                      child: StatusBadgeWidget(
                        title: AppStrings.unpaid,
                        text: '2',
                      ),
                    ),
                    Expanded(
                      child: StatusBadgeWidget(
                        title: AppStrings.unfulfilled,
                        text: '2',
                        color: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          SizedBox(height: 8),
          Divider(thickness: 1, color: Colors.grey[300]),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: AppText.heading2(
                  AppStrings.homeLatest,
                  color: Colors.grey[700],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: selectedPageNotifier,
                      builder: (context, value, _) {
                        return GestureDetector(
                          onTap: () {
                            selectedPageNotifier.value = 1;
                          },
                          child: Text(AppStrings.homeLatestAll),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Image.asset(
                              'assets/images/products/${index + 1}.png',
                              width: 100,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: AppText.gridTitle(products[index]['name']),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: AppText.gridPrice('150.000')),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8),
          Divider(thickness: 1, color: Colors.grey[300]),
          SizedBox(height: 8),
          AppText.heading2(AppStrings.homeRecent, color: Colors.grey[700]),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppText.bold(
                          "Order #${transactions[index]['order_no']}",
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppText.gridPrice(
                              transactions[index]['total'].toString(),
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
      ),
    );
  }
}
