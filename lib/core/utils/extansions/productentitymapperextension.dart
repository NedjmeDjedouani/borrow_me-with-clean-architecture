import 'package:test_app/features/order/data/models/product.dart';
import 'package:test_app/features/order/domain/entities/productentity.dart';

extension ProductModelMapper on ProductEntity {
  ProductModel toProductModel() {
    return ProductModel(
        barcode: this.barcode,
        createdAt: this.createdAt,
        id: this.id,
        name: this.productname,
        price: this.price);
  }
}
