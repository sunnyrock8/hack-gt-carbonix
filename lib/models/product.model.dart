import 'dart:math';

class Product {
  late final String id;
  final String name;
  final double? completion;
  final String image;
  final String? description;
  final List<String>? tags;
  final double price;
  final int? quantity;
  final String vendorWallet;
  bool active;

  Product({
    String? id,
    required this.name,
    required this.completion,
    required this.image,
    this.active = false,
    this.description = '',
    this.tags = const [],
    required this.price,
    required this.vendorWallet,
    this.quantity = 0,
  }) {
    if (id != null)
      this.id = id;
    else {
      this.id = Random().nextInt(100).toString();
    }
  }

  Product copyWith(
      {String? id,
      String? name,
      double? completion,
      String? image,
      bool? active,
      String? description,
      List<String>? tags,
      double? price,
      int? quantity,
      String? vendorWallet}) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      completion: completion ?? this.completion,
      image: image ?? this.image,
      active: active ?? this.active,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      vendorWallet: vendorWallet ?? this.vendorWallet,
    );
  }
}
