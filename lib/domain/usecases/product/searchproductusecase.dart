import '../../../../../core/usecases/usecase.dart';
import '../../entities/productentity.dart';
import '../../repositories/productrepository.dart';

class SearchProductUseCase
    implements UseCase<Future<List<ProductEntity>>, String> {
  SearchProductUseCase(this._productRepository);
  final ProductRepository _productRepository;
  @override
  Future<List<ProductEntity>> call(String name) async {
    return await _productRepository.searchProduct(name);
  }
}
