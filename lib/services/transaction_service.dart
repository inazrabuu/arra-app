import 'package:arrajewelry/constants/app_strings.dart';
import 'package:arrajewelry/models/transaction_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<TransactionModel>> fetchAll({int limit = 100}) async {
    final response = await _client
        .from(TransactionModel.tableName)
        .select()
        .order('trx_date', ascending: false)
        .limit(limit);

    return (response as List)
        .map((json) => TransactionModel.fromJson(json))
        .toList();
  }

  Future<TransactionModel> getById(int id) async {
    TransactionModel t = TransactionModel.empty();
    final response =
        await _client
            .from(TransactionModel.tableName)
            .select()
            .eq('id', id)
            .maybeSingle();

    if (response != null) {
      t = TransactionModel.fromJson(response);
    }

    return t;
  }

  Future<int> countUns(String what) async {
    String field = 'is_$what';

    final response = await _client
        .from(TransactionModel.tableName)
        .select('id')
        .eq(field, false);

    return response.length;
  }

  Future<double> calculateBalance() async {
    final int sumDebits = await _client.rpc('sum_transaction_debits');
    final int sumCredits = await _client.rpc('sum_transaction_credits');

    return (sumCredits - sumDebits).toDouble();
  }

  Future<String> save(TransactionModel transaction) async {
    final response = await _client
        .from(TransactionModel.tableName)
        .upsert(transaction.toJson());

    if (response != null) {
      if (response.error != null) {
        throw Exception('Failed to save: ${response.error!.message}');
      }
    }

    return AppStrings.success;
  }

  dynamic delete(int id) async {
    final response = await _client
        .from(TransactionModel.tableName)
        .delete()
        .eq('id', id);

    return response;
  }
}
