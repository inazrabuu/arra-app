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

  Future<int> countUns(String what) async {
    String field = 'is_$what';

    final response = await _client
        .from(TransactionModel.tableName)
        .select('id', const FetchOptions(count: CountOption.exact))
        .eq(field, false);

    return response.count;
  }

  Future<double> calculateBalance() async {
    final int sumDebits = await _client.rpc('sum_transaction_debits');
    final int sumCredits = await _client.rpc('sum_transaction_credits');

    print(sumDebits);

    return (sumCredits - sumDebits).toDouble();
  }
}
