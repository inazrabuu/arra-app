import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/models/product_model.dart';
import 'package:arrajewelry/services/product_service.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/products_grid_widget.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductService productService = ProductService();
  List<ProductModel> _products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final data = await productService.fetchAll();
    setState(() => _products = data);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.heading(AppStrings.productPageTitle),
          Row(
            children: [
              Text('Products Count : '),
              Text(
                _products.length.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(12.0)),
          ProductsGridWidget(items: _products),
        ],
      ),
    );
  }
}
