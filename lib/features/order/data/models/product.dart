import 'package:test_app/features/order/domain/entities/productentity.dart';

class ProductKeys {
  static final id = "id";
  static final barCode = "bar_code";
  static final name = "name";
  static final price = "price";
  static final createdAt = "created_at";
}

class ProductModel extends ProductEntity {
  ProductModel(
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
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(map[ProductKeys.createdAt]),
        id: map[ProductKeys.id],
        name: map[ProductKeys.name],
        price: map[ProductKeys.price]);
  }

  Map<String, dynamic> toMap() => {
        ProductKeys.barCode: barcode,
        ProductKeys.createdAt: createdAt,
        ProductKeys.id: id,
        ProductKeys.name: productname,
        ProductKeys.price: price
      };
}
