class ProductModel {
  final int id;
  final DateTime createdAt;
  final String name;
  final String cat;
  final String image;
  final double price;
  final bool inTiktok;
  final bool inShopee;
  final int stock;

  ProductModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.cat,
    required this.image,
    required this.price,
    required this.inTiktok,
    required this.inShopee,
    required this.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      name: json['name'],
      cat: json['cat'],
      image: json['image'],
      price:
          (json['price'] is int)
              ? json['price'].toDouble()
              : (json['price'] is double)
              ? json['price']
              : double.tryParse(json['price']) ?? 0.0,
      inTiktok: json['in_tiktok'],
      inShopee: json['in_shopee'],
      stock: json['stock'],
    );
  }
}
