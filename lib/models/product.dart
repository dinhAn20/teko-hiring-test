class Product {
  final String name;
  final int price;
  final String? imageSrc;

  Product({
    required this.name,
    required this.price,
    this.imageSrc,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      imageSrc: json['imageSrc'],
    );
  }
  Product copyWith({
    String? name,
    int? price,
    String? imageSrc,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      imageSrc: imageSrc ?? this.imageSrc,
    );
  }
}
