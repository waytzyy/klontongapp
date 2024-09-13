class Product {
  final String id;
  final String categoryId; // Changed to String
  final String categoryName;
  final String sku;
  final String name;
  final String description;
  final double weight;
  final double width;
  final double length;
  final double height;
  final String image;
  final double harga;

  Product({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.sku,
    required this.name,
    required this.description,
    required this.weight,
    required this.width,
    required this.length,
    required this.height,
    required this.image,
    required this.harga,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String? ?? '', // Provide default value if null
      categoryId: json['CategoryId'] as String? ?? '', // Provide default value if null
      categoryName: json['categoryName'] as String? ?? '', // Provide default value if null
      sku: json['sku'] as String? ?? '', // Provide default value if null
      name: json['name'] as String? ?? '', // Provide default value if null
      description: json['description'] as String? ?? '', // Provide default value if null
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0, // Handle null and convert to double
      width: (json['width'] as num?)?.toDouble() ?? 0.0, // Handle null and convert to double
      length: (json['length'] as num?)?.toDouble() ?? 0.0, // Handle null and convert to double
      height: (json['height'] as num?)?.toDouble() ?? 0.0, // Handle null and convert to double
      image: json['image'] as String? ?? '', // Provide default value if null
      harga: (json['harga'] as num?)?.toDouble() ?? 0.0, // Handle null and convert to double
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'CategoryId': categoryId,
      'categoryName': categoryName,
      'sku': sku,
      'name': name,
      'description': description,
      'weight': weight,
      'width': width,
      'length': length,
      'height': height,
      'image': image,
      'harga': harga,
    };
  }
}
