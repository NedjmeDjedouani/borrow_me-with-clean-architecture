import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/order/domain/entities/productentity.dart';
import 'package:test_app/features/order/domain/repositories/productrepository.dart';

class GetAllProductsUseCase
    implements UseCase<Future<List<ProductEntity>>, NoParams> {
  GetAllProductsUseCase(this._productRepository);
  final ProductRepository _productRepository;
  @override
  Future<List<ProductEntity>> call(NoParams params) async {
   return await  _productRepository.getAllProducts();
  }
}
