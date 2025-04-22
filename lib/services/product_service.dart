import 'package:arrajewelry/models/product_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient client = Supabase.instance.client;
  final bucket = dotenv.env['SUPABASE_BUCKET'];
  final bucketProduct = dotenv.env['BUCKET_PRODUCT'];

  Future<List<ProductModel>> fetchAll() async {
    final response = await client
        .from('products')
        .select()
        .order('name', ascending: true);

    return (response as List)
        .map((json) => ProductModel.fromJson(json))
        .toList();
  }
}
