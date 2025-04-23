class DataDummies {
  static List<Map<String, dynamic>> transactions = [
    {
      'order_no': '00000001',
      'name': 'Richard',
      'date': '2025-01-01',
      'paid': true,
      'fulfilled': true,
      'total': 300000.00,
      'detail': [],
    },
    {
      'order_no': '00000002',
      'name': 'Mbak Mia',
      'date': '2025-01-02',
      'paid': true,
      'fulfilled': true,
      'total': 350000.00,
      'detail': [],
    },
    {
      'order_no': '00000003',
      'date': '2025-01-03',
      'name': 'Bu Dewi',
      'paid': true,
      'fulfilled': true,
      'total': 150000.00,
      'detail': [],
    },
    {
      'order_no': '00000004',
      'name': 'Mayang',
      'date': '2025-01-04',
      'paid': false,
      'fulfilled': true,
      'total': 200000.00,
      'detail': [],
    },
    {
      'order_no': '00000005',
      'name': 'Nenek',
      'date': '2025-01-04',
      'paid': true,
      'fulfilled': false,
      'total': 300000.00,
      'detail': [],
    },
    {
      'order_no': '00000006',
      'name': 'Pengunjung pagi',
      'date': '2025-01-05',
      'paid': true,
      'fulfilled': true,
      'total': 300000.00,
      'detail': [],
    },
  ];

  static List<Map<String, dynamic>> products = [
    {'cat': 'anting', 'name': "chandraprabha", "price": "150.000"},
    {'cat': 'gelang', 'name': "sringai", "price": "150.000"},
    {'cat': 'kalung', 'name': "leela", "price": "150.000"},
    {'cat': "cincin", 'name': 'vagni', "price": "150.000"},
    {'cat': "anting", 'name': 'lontong', "price": "150.000"},
  ];
}
