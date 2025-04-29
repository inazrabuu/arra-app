import 'package:arrajewelry/models/product_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient client = Supabase.instance.client;
  final bucket = dotenv.env['SUPABASE_BUCKET'];
  final bucketProduct = dotenv.env['BUCKET_PRODUCT'];

  Future<ProductModel> getByName(String name) async {
    ProductModel r = ProductModel.empty();
    final response =
        await client
            .from(ProductModel.tableName)
            .select()
            .eq('name', name)
            .limit(1)
            .maybeSingle();

    if (response != null) {
      r = ProductModel.fromJson(response);
    }

    return r;
  }

  Future<List<ProductModel>> fetchAll({int limit = 100}) async {
    final response = await client
        .from(ProductModel.tableName)
        .select()
        .order('name', ascending: true)
        .limit(limit);

    return (response as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }

  Future<List<ProductModel>> fetchLatest({int limit = 100}) async {
    final response = await client
        .from(ProductModel.tableName)
        .select()
        .order('created_at', ascending: false)
        .limit(limit);

    return (response as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }
}
