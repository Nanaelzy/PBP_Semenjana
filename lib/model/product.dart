class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String imagePath;
  final String description;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.description,
    required this.stock,
  });

  String get formattedPrice =>
      'Rp ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

  bool get isAvailable => stock > 0;

  @override
  String toString() {
    return 'Product{id: $id, name: $name, category: $category, price: $price, stock: $stock}';
  }

  // Method untuk duplikasi objek
  Product copyWith({
    int? id,
    String? name,
    String? category,
    double? price,
    String? imagePath,
    String? description,
    int? stock,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      stock: stock ?? this.stock,
    );
  }
}

class Shirt extends Product {
  final String size;
  final String material;

  Shirt({
    required super.id,
    required super.name,
    required super.price,
    required super.imagePath,
    required super.description,
    required super.stock,
    required this.size,
    required this.material,
  }) : super(category: 'Shirt');
}

class Accessory extends Product {
  final String type;

  Accessory({
    required super.id,
    required super.name,
    required super.price,
    required super.imagePath,
    required super.description,
    required super.stock,
    required this.type,
  }) : super(category: 'Accessory');
}
