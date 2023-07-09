import '../../domain/entities/productentity.dart';

class ProductKeys {
  static const id = "id";
  static const barCode = "barcode";
  static const name = "name";
  static const price = "price";
  static const createdAt = "created_at";
}

class ProductModel extends ProductEntity {
  const ProductModel(
      {String? barcode,
      String? id,
      DateTime? createdAt,
      double? price,
      String? name})
      : super(
            barcode: barcode,
            createdAt: createdAt,
            id: id,
            price: price,
            productname: name);

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        barcode: map[ProductKeys.barCode],
        createdAt: DateTime.parse(map[ProductKeys.createdAt]),
        id: map[ProductKeys.id].toString(),
        name: map[ProductKeys.name],
        price: double.parse(map[ProductKeys.price].toString()));
  }

  Map<String, dynamic> toMap() => {
        ProductKeys.barCode: barcode,
        ProductKeys.createdAt: createdAt,
        ProductKeys.id: id,
        ProductKeys.name: productname,
        ProductKeys.price: price
      };
}
