import 'package:arrajewelry/models/product_model.dart';
import 'package:arrajewelry/services/product_service.dart';

class AppData {
  static final AppData _instance = AppData._internal();
  ProductService productService = ProductService();

  factory AppData() => _instance;

  AppData._internal();

  List<ProductModel>? products;

  Future<void> loadProducts() async {
    products = await productService.fetchAll();
  }

  Future<void> reloadProducts() async {
    loadProducts();
  }
}
