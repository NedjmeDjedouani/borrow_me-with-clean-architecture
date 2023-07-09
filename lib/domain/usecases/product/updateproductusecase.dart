import '../../../../../core/usecases/usecase.dart';
import '../../entities/productentity.dart';
import '../../repositories/productrepository.dart';

class UpdateProductUseCase
    implements UseCase<Future<void>, ProductEntity> {
  UpdateProductUseCase(this._productRepository);
  final ProductRepository _productRepository;
  @override
  Future<void> call(ProductEntity productEntity) async {
     await _productRepository.updateProduct(productEntity);
  }
}
