import 'dart:convert';

class ItemModel {
  String itemId;
  String authId;
  String name;
  String description;
  String price;
  String image;
  String category;
  bool isDeleted;
  int createdAt;
  ItemModel({
    required this.itemId,
    required this.authId,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.isDeleted,
    required this.createdAt,
  });

  ItemModel copyWith({
    String? itemId,
    String? authId,
    String? name,
    String? description,
    String? price,
    String? image,
    String? category,
    bool? isDeleted,
    int? createdAt,
  }) {
    return ItemModel(
      itemId: itemId ?? this.itemId,
      authId: authId ?? this.authId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemId': itemId,
      'authId': authId,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      itemId: map['itemId'] as String,
      authId: map['authId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
      image: map['image'] as String,
      category: map['category'] as String,
      isDeleted: map['isDeleted'] as bool,
      createdAt: map['createdAt'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(itemId: $itemId, authId: $authId, name: $name, description: $description, price: $price, image: $image, category: $category, isDeleted: $isDeleted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;

    return other.itemId == itemId &&
        other.authId == authId &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.image == image &&
        other.category == category &&
        other.isDeleted == isDeleted &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return itemId.hashCode ^
        authId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        image.hashCode ^
        category.hashCode ^
        isDeleted.hashCode ^
        createdAt.hashCode;
  }
}
