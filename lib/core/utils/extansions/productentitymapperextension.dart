

import '../../../data/models/product.dart';
import '../../../domain/entities/productentity.dart';

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
