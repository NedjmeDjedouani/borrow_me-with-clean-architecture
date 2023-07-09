import 'package:test_app/features/order/data/models/product.dart';
import 'package:test_app/features/order/domain/entities/productentity.dart';

extension ProductModelMapper on ProductEntity {
  ProductModel toProductModel() {
    return ProductModel(
        barcode: barcode,
        createdAt: createdAt,
        id: id,
        name: productname,
        price: price);
  }
}
