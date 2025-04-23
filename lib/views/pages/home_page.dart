import 'package:arrajewelry/models/product_model.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:arrajewelry/services/product_service.dart';
import 'package:arrajewelry/services/transaction_service.dart';
import 'package:arrajewelry/views/widgets/home_latest_widget.dart';
import 'package:arrajewelry/views/widgets/home_recent_widget.dart';
import 'package:arrajewelry/views/widgets/home_status_snapshot_widget.dart';
import 'package:flutter/material.dart';
import 'package:arrajewelry/data/dummies.dart';
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
  double _balance = 0;
  int _unpaid = 0;
  int _unfulfilled = 0;

  @override
  initState() {
    super.initState();
    loadData();
  }

  loadData() {
    calculateBalance();
    loadLatestProducts();
    loadRecentTransaction();
    countUns();
  }

  Future<void> calculateBalance() async {
    final data = await transactionService.calculateBalance();
    setState(() => _balance = data);
  }

  countUns() async {
    int cp = await transactionService.countUns('paid');
    int cf = await transactionService.countUns('fulfilled');
    setState(() {
      _unpaid = cp;
      _unfulfilled = cf;
    });
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
    loadData();
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
            HomeStatusSnapshotWidget(
              balance: _balance,
              unfulfilled: _unfulfilled,
              unpaid: _unpaid,
            ),
            SizedBox(height: 8),
            Divider(thickness: 1, color: Colors.grey[300]),
            SizedBox(height: 8),
            HomeLatestWidget(items: _latest),
            SizedBox(height: 8),
            Divider(thickness: 1, color: Colors.grey[300]),
            SizedBox(height: 8),
            HomeRecentWidget(items: _recent),
          ],
        ),
      ),
    );
  }
}
