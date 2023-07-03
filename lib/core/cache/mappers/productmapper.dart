import 'package:test_app/core/cache/db.dart';
import 'package:test_app/core/cache/entitymapper.dart';
import 'package:test_app/features/order/data/models/product.dart';

class ProductEntityMapper implements EntityMapper<ProductModel,Product> {
  
  Product mapToCached(ProductModel productEntity) {
    return Product(
        name: productEntity.productname!,
        barcode: productEntity.barcode!,
        remoteId: productEntity.id!,
        price: productEntity.price!,
        createdAt: productEntity.createdAt!);
  }

  ProductModel cachedToMap(Product product) {
    return ProductModel(
        barcode: product.barcode,
        createdAt: product.createdAt,
        id: product.remoteId,
        price: product.price,
        name: product.name);
  }
  
}
