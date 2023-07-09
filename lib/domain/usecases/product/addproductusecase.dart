import 'package:test_app/core/usecases/usecase.dart';
import '../../entities/productentity.dart';
import '../../repositories/productrepository.dart';

class AddProductUseCase implements UseCase<Future<void>, ProductEntity> {
  AddProductUseCase(this._productRepository);
  final ProductRepository _productRepository;

  @override
  Future<void> call(ProductEntity productEntity) async {
    await _productRepository.addProduct(productEntity);
  }
}
