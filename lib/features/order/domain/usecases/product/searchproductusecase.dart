import 'package:test_app/features/order/domain/entities/productentity.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/productrepository.dart';

class SearchProductUseCase
    implements UseCase<Future<List<ProductEntity>>, String> {
  SearchProductUseCase(this._productRepository);
  ProductRepository _productRepository;
  @override
  Future<List<ProductEntity>> call(String name) async {
    return await _productRepository.searchProduct(name);
  }
}
