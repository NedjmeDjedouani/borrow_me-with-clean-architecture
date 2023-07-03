import 'package:test_app/features/order/domain/entities/productentity.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/productrepository.dart';

class UpdateProductUseCase
    implements UseCase<Future<void>, ProductEntity> {
  UpdateProductUseCase(this._productRepository);
  ProductRepository _productRepository;
  @override
  Future<void> call(ProductEntity productEntity) async {
     await _productRepository.updateProduct(productEntity);
  }
}
