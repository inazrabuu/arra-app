import 'dart:convert';

class TransactionModel {
  final int id;
  final DateTime createdAt;
  final String orderNo;
  final String name;
  final String description;
  final double total;
  final bool isPaid;
  final bool isFulfilled;
  final List<Map<String, dynamic>> detail;
  final DateTime trxDate;
  final bool isDebit;

  static String tableName = 'transactions';

  TransactionModel({
    required this.id,
    required this.createdAt,
    required this.orderNo,
    required this.name,
    required this.description,
    required this.total,
    required this.isPaid,
    required this.isFulfilled,
    required this.detail,
    required this.trxDate,
    required this.isDebit,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = jsonDecode(json['detail']);
    List<Map<String, dynamic>> detail =
        data.map((item) => Map<String, dynamic>.from(item)).toList();

    return TransactionModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      orderNo: json['id'].toString().padLeft(7, '0'),
      name: json['name'],
      description: json['description'],
      total:
          (json['total'] is int)
              ? json['total'].toDouble()
              : (json['total'] is double)
              ? json['total']
              : json['total'] ?? 0.0,
      isPaid: json['is_paid'],
      isFulfilled: json['is_fulfilled'],
      detail: detail,
      trxDate: DateTime.parse(json['trx_date']),
      isDebit: json['is_debit'],
    );
  }
}
