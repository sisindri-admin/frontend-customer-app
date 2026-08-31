class ProductModel {
  final String id;
  final String title;
  final String category;
  final String unit;
  final double price;
  final double oldPrice;
  final String imageUrl;
  final bool inStock;

  ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.unit,
    required this.price,
    this.oldPrice = 0.0,
    required this.imageUrl,
    this.inStock = true,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ProductModel(
      id: documentId,
      title: data['title'] ?? data['name'] ?? '',
      category: data['category'] ?? 'Groceries',
      unit: data['unit'] ?? '1 unit',
      price: (data['price'] is int)
          ? (data['price'] as int).toDouble()
          : (data['price'] as double? ?? 0.0),
      oldPrice: (data['oldPrice'] is int)
          ? (data['oldPrice'] as int).toDouble()
          : (data['oldPrice'] as double? ?? 0.0),
      imageUrl: data['imageUrl'] ?? 'https://via.placeholder.com/150',
      inStock: data['inStock'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'unit': unit,
      'price': price,
      'oldPrice': oldPrice,
      'imageUrl': imageUrl,
      'inStock': inStock,
    };
  }
}