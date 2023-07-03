import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/order/domain/entities/productentity.dart';
import 'package:test_app/features/order/domain/repositories/productrepository.dart';

class AddProductUseCase implements UseCase<Future<void>, ProductEntity> {
  AddProductUseCase(this._productRepository);
  ProductRepository _productRepository;

  @override
  Future<void> call(ProductEntity productEntity) async {
    await _productRepository.addProduct(productEntity);
  }
}
