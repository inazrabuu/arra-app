import 'package:arrajewelry/data/notifiers.dart';
import 'package:arrajewelry/models/product_model.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:arrajewelry/services/product_service.dart';
import 'package:arrajewelry/services/transaction_service.dart';
import 'package:arrajewelry/views/widgets/home_latest_widget.dart';
import 'package:arrajewelry/views/widgets/home_status_snapshot_widget.dart';
import 'package:flutter/material.dart';
import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/dummies.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/greeting_widget.dart';

class HomePage extends StatefulWidget {
  static List<Map<String, dynamic>> transactions = DataDummies.transactions;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TransactionService transactionService = TransactionService();
  final ProductService productService = ProductService();
  List<ProductModel> _latest = [];
  List<TransactionModel> _recent = [];

  @override
  initState() {
    super.initState();
    loadLatestProducts();
    loadRecentTransaction();
  }

  Future<void> loadLatestProducts() async {
    final data = await productService.fetchLatest(limit: 6);
    setState(() => _latest = data);
  }

  Future<void> loadRecentTransaction() async {
    final data = await transactionService.fetchAll(limit: 10);
    setState(() => _recent = data);
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    print('refreshed!');
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingWidget(),
            SizedBox(height: 8),
            HomeStatusSnapshotWidget(),
            SizedBox(height: 8),
            Divider(thickness: 1, color: Colors.grey[300]),
            SizedBox(height: 8),
            HomeLatestWidget(items: _latest),
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
                            "Order #${HomePage.transactions[index]['order_no']}",
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AppText.gridPrice(
                                HomePage.transactions[index]['total']
                                    .toString(),
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
      ),
    );
  }
}
