import 'dart:typed_data';

class Category {
  int? id;
  String cat_name;
  Uint8List cat_image;

  Category({
    required this.cat_name,
    required this.cat_image,
    this.id,
  });

  factory Category.fromDB({required Map data}) {
    return Category(
      cat_name: data['cat_name'],
      cat_image: data['cat_image'],
      id: data['id'],
    );
  }
}
