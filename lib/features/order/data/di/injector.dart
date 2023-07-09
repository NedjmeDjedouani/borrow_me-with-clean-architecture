import 'package:get/get.dart';
import 'package:test_app/core/api/apiconsumer.dart';
import 'package:test_app/core/cache/db.dart';
import 'package:test_app/core/networkinfo/networkinfo.dart';
import 'package:test_app/features/order/data/datasources/local/client_local_ds.dart';
import 'package:test_app/features/order/data/datasources/local/order_local_ds.dart';
import 'package:test_app/features/order/data/datasources/local/product_local_ds.dart';
import 'package:test_app/features/order/data/datasources/remote/product_remote_ds_imp.dart';
import 'package:test_app/features/order/data/datasources/source/client_local_datasource.dart';
import 'package:test_app/features/order/data/datasources/source/client_remote_datasource.dart';
import 'package:test_app/features/order/data/datasources/source/order_local_ds.dart';
import 'package:test_app/features/order/data/datasources/source/order_remote_ds.dart';
import 'package:test_app/features/order/data/datasources/source/product_local_ds.dart';
import 'package:test_app/features/order/data/datasources/source/product_remote_ds.dart';
import 'package:test_app/features/order/data/repositories/clientrepository.dart';
import 'package:test_app/features/order/data/repositories/orderrepository.dart';
import 'package:test_app/features/order/domain/repositories/clientrepository.dart';
import 'package:test_app/features/order/domain/repositories/orderrepository.dart';
import 'package:test_app/features/order/domain/repositories/productrepository.dart';
import 'package:test_app/features/order/domain/usecases/client/addclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/client/getallclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/client/getclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/client/removeclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/client/updateclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/order/addorderusecase.dart';
import 'package:test_app/features/order/domain/usecases/order/getallordersusecase.dart';
import 'package:test_app/features/order/domain/usecases/order/getordersbyclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/order/getorderusecase.dart';
import 'package:test_app/features/order/domain/usecases/order/removeodersbyclientusecase.dart';
import 'package:test_app/features/order/domain/usecases/product/addproductusecase.dart';
import 'package:test_app/features/order/domain/usecases/product/getallproductsusecase.dart';
import 'package:test_app/features/order/domain/usecases/product/getproductusecase.dart';
import 'package:test_app/features/order/domain/usecases/product/removeproductusecase.dart';
import 'package:test_app/features/order/domain/usecases/product/searchproductusecase.dart';
import 'package:test_app/features/order/domain/usecases/product/updateproductusecase.dart';

import '../../domain/usecases/order/removeorderusecase.dart';
import '../datasources/remote/client_remote_ds_imp.dart';
import '../datasources/remote/order_remote_ds_imp.dart';
import '../repositories/productrepository.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
//mappers

//services

    Get.put<NetworkInfo>(NetworkInfoImpl());
    Get.put<ApiConsumer>(DioConsumer());
    Get.put<LocalDatabase>(LocalDatabase());

    //local data sources

    Get.put<OrderLocalDataSource>(
        OrderLocalDataSourceImp(Get.find<LocalDatabase>()));
    Get.put<ProductLocalDataSource>(
        ProductLocalDataSourceImp(Get.find<LocalDatabase>()));
    Get.put<ClientLocalDataSource>(
        ClientLocalDatatSourceImp(Get.find<LocalDatabase>()));

    //remote data sources

    Get.put<ProductRemoteDataSource>(
        ProductRemoteDataSourceImp(Get.find<ApiConsumer>()));
    Get.put<ClientRemoteDataSource>(ClientRemoteDataSourceImp(Get.find()));
    Get.put<OrderRemoteDataSource>(
        OrderRemoteDataSourceImp(Get.find<ApiConsumer>()));

    //repositories

    Get.put<ProductRepository>(ProductRepositoryImp(
        networkInfo: Get.find(),
        productLocalDataSource: Get.find(),
        productRemoteDataSource: Get.find()));
    Get.put<OrderRepository>(OrderRepositoryImp(
        networkInfo: Get.find(),
        orderLocalDataSource: Get.find<OrderLocalDataSource>(),
        orderRemoteDataSource: Get.find<OrderRemoteDataSource>()));
    Get.put<ClientRepository>(ClientRepositoryImp(
        clientLocalDataSource: Get.find(),
        clientremoteDataSource: Get.find(),
        networkInfo: Get.find()));

// product usecases
    Get.lazyPut(() => GetProductUseCase(Get.find()));
    Get.lazyPut(() => GetAllProductsUseCase(Get.find()));
    Get.lazyPut(() => AddProductUseCase(Get.find()));
    Get.lazyPut(() => RemoveProductUseCase(Get.find()));
    Get.lazyPut(() => UpdateProductUseCase(Get.find()));
    Get.lazyPut(() => SearchProductUseCase(Get.find()));

// client usecases
    Get.lazyPut(() => GetClientUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetAllClientUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => UpdateClientUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => RemoveClientUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => AddClientUseCase(Get.find()), fenix: true);

// order usecases
    Get.lazyPut(() => AddOrderUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => RemoveOrderUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetOrderUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetAllOrdersUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetOrdersByClientUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => RemoveOrderUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => RemoveOrdersByClientUseCase(Get.find()), fenix: true);
  }
}
