import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/data/dummies.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/products_grid_widget.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  static final List<Map<String, dynamic>> items = DataDummies.products;

  const ProductPage({super.key});

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
                items.length.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(12.0)),
          ProductsGridWidget(items: items),
        ],
      ),
    );
  }
}
