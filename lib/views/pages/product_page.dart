import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/views/theme/text_styles.dart';
import 'package:arrajewelry/views/widgets/products_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';

class ProductPage extends StatelessWidget {
  static const List<Map<String, dynamic>> items = [
    {'cat': 'anting', 'name': "chandraprabha", "price": "150.000"},
    {'cat': 'gelang', 'name': "sringai", "price": "150.000"},
    {'cat': 'kalung', 'name': "leela", "price": "150.000"},
    {'cat': "cincin", 'name': 'vagni', "price": "150.000"},
    {'cat': "anting", 'name': 'lontong', "price": "150.000"},
  ];

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
