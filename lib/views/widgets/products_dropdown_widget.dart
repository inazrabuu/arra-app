import 'package:arrajewelry/models/product_model.dart';
import 'package:arrajewelry/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductDropdownWidget extends StatefulWidget {
  const ProductDropdownWidget({super.key});

  @override
  State<ProductDropdownWidget> createState() => _ProductDropdownWidgetState();
}

class _ProductDropdownWidgetState extends State<ProductDropdownWidget> {
  final ProductService productService = ProductService();
  List<ProductModel> _products = [];
  String? _selectedItem;

  @override
  initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final r = await productService.fetchAll();
    setState(() {
      _products = r;
      _selectedItem = r.isNotEmpty ? r.first.name : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      ),
      value: _selectedItem,
      items:
          _products.map((i) {
            return DropdownMenuItem<String>(value: i.name, child: Text(i.name));
          }).toList(),
      onChanged: (value) {
        setState(() => _selectedItem = value);
      },
    );
  }
}
