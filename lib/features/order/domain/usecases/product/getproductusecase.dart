import '../../../../../core/usecases/usecase.dart';
import '../../entities/productentity.dart';
import '../../repositories/productrepository.dart';

class GetProductUseCase
    implements UseCase<Future<ProductEntity>, String> {
  GetProductUseCase(this._productRepository);
  ProductRepository _productRepository;
  @override
  Future<ProductEntity> call(String productId) async {
    return await _productRepository.getProduct(productId);
  }
}
