class TransactionModel {
  final int? id;
  final DateTime? createdAt;
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
    this.id,
    this.createdAt,
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

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    'order_no': '',
    'name': name,
    'description': description,
    'total': total,
    'is_paid': isPaid,
    'is_fulfilled': isFulfilled,
    'detail': detail,
    'trx_date': trxDate.toIso8601String(),
    'is_debit': isDebit,
  };

  factory TransactionModel.empty() {
    return TransactionModel(
      id: 0,
      createdAt: DateTime.parse('1900-01-01 00:00:00'),
      orderNo: '',
      name: '',
      description: '',
      detail: [],
      isDebit: false,
      isPaid: false,
      isFulfilled: false,
      total: 0,
      trxDate: DateTime.parse('1900-01-01 00:00:00'),
    );
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['detail'];
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
