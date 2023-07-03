import '../../../../../core/usecases/usecase.dart';
import '../../repositories/productrepository.dart';

class RemoveProductUseCase
    implements UseCase<Future<void>, String> {
  RemoveProductUseCase(this._productRepository);
  ProductRepository _productRepository;
  @override
  Future<void> call(String productId) async {
     await _productRepository.removeProduct(productId);
  }
}
