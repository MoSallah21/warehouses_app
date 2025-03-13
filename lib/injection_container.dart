import 'package:eks/core/network/local/remote/network_info.dart';
import 'package:eks/features/account_management/data/datasources/remote/accounts_remote_datasource.dart';
import 'package:eks/features/account_management/data/repositories/accounts_repository_imp.dart';
import 'package:eks/features/account_management/domain/repositories/accounts_repository.dart';
import 'package:eks/features/account_management/domain/usecases/add/add_customer.dart';
import 'package:eks/features/account_management/domain/usecases/add/add_dealer.dart';
import 'package:eks/features/account_management/domain/usecases/add/add_delegate.dart';
import 'package:eks/features/account_management/domain/usecases/delete/delete_customer.dart';
import 'package:eks/features/account_management/domain/usecases/delete/delete_dealer.dart';
import 'package:eks/features/account_management/domain/usecases/delete/delete_delegate.dart';
import 'package:eks/features/account_management/domain/usecases/get/get_all_customers.dart';
import 'package:eks/features/account_management/domain/usecases/get/get_all_dealers.dart';
import 'package:eks/features/account_management/domain/usecases/get/get_all_delegates.dart';
import 'package:eks/features/account_management/domain/usecases/update/update_customer.dart';
import 'package:eks/features/account_management/domain/usecases/update/update_dealer.dart';
import 'package:eks/features/account_management/domain/usecases/update/update_delegate.dart';
import 'package:eks/features/account_management/presentation/cubit/account_cubit.dart';
import 'package:eks/features/invoice_management/data/datasources/remote/invoice_remote_datasource.dart';
import 'package:eks/features/invoice_management/data/repositories/invoice_repository_imp.dart';
import 'package:eks/features/invoice_management/domain/repositories/invoice_repository.dart';
import 'package:eks/features/invoice_management/domain/usecases/add_invoice.dart';
import 'package:eks/features/invoice_management/domain/usecases/delete_invoice.dart';
import 'package:eks/features/invoice_management/domain/usecases/get_all_invoices.dart';
import 'package:eks/features/invoice_management/domain/usecases/get_invoice.dart';
import 'package:eks/features/invoice_management/domain/usecases/update_invoice.dart';
import 'package:eks/features/invoice_management/presentation/cubit/invoice_cubit.dart';
import 'package:eks/features/product_management/data/datasources/remote/product_remote_datasource.dart';
import 'package:eks/features/product_management/data/datasources/remote/unit_remote_datasource.dart';
import 'package:eks/features/product_management/data/repositories/product_repository_imp.dart';
import 'package:eks/features/product_management/data/repositories/unit_repository_imp.dart';
import 'package:eks/features/product_management/domain/repositories/product_repository.dart';
import 'package:eks/features/product_management/domain/repositories/unit_repository.dart';
import 'package:eks/features/product_management/domain/usecases/add/add_product.dart';
import 'package:eks/features/product_management/domain/usecases/add/add_unit.dart';
import 'package:eks/features/product_management/domain/usecases/delete/delete_product.dart';
import 'package:eks/features/product_management/domain/usecases/delete/delete_unit.dart';
import 'package:eks/features/product_management/domain/usecases/get/get_all_products.dart';
import 'package:eks/features/product_management/domain/usecases/get/get_all_units.dart';
import 'package:eks/features/product_management/domain/usecases/update/update_product.dart';
import 'package:eks/features/product_management/domain/usecases/update/update_unit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'features/product_management/presentation/cubit/product_cubit.dart';

final sl=GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
    internetConnectionChecker: sl(),
  ));

  // External
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());

  // DataSources
  // Accounts

  sl.registerLazySingleton<AccountsRemoteDatasource>(() => AccountsRemoteDatasourceImp(client: sl()
  ));
  //Product
  sl.registerLazySingleton<ProductRemoteDatasource>(() => ProductRemoteDatasourceImp(client: sl()
  ));
  //Unit
  sl.registerLazySingleton<UnitRemoteDatasource>(() => UnitRemoteDatasourceImp(client: sl()
  ));
  //Invoice
  sl.registerLazySingleton<InvoiceRemoteDatasource>(() => InvoiceRemoteDatasourceImp(client: sl()
  ));


  // Repository
  // Accounts
  sl.registerLazySingleton<AccountsRepository>(() => AccountsRepositoryImp(
    remoteDatasource: sl(),
    networkInfo: sl(),
  ));
  //Product
  sl.registerLazySingleton<ProductRepository>(() => ProductsRepositoryImp(
    remoteDatasource: sl(),
    networkInfo: sl(),
  ));
  //Unit
  sl.registerLazySingleton<UnitRepository>(() => UnitRepositoryImp(
    remoteDatasource: sl(),
    networkInfo: sl(),
  ));
  //Invoice
  sl.registerLazySingleton<InvoiceRepository>(() => InvoiceRepositoryImp(
    remoteDatasource: sl(),
    networkInfo: sl(),
  ));



  // UseCases

  //Accounts
  sl.registerLazySingleton(() => AddDelegateUseCase(sl()));

  sl.registerLazySingleton(() => AddDealerUseCase(sl()));

  sl.registerLazySingleton(() => AddCustomerUseCase(sl()));

  sl.registerLazySingleton(() => UpdateDealerUseCase(sl()));

  sl.registerLazySingleton(() => UpdateCustomerUseCase(sl()));

  sl.registerLazySingleton(() => UpdateDelegateUseCase(sl()));

  sl.registerLazySingleton(() => DeleteDealerUseCase(sl()));

  sl.registerLazySingleton(() => DeleteCustomerUseCase(sl()));

  sl.registerLazySingleton(() => DeleteDelegateUseCase(sl()));

  sl.registerLazySingleton(() => GetAllDealersUseCase(sl()));

  sl.registerLazySingleton(() => GetAllCustomersUseCase(sl()));

  sl.registerLazySingleton(() => GetAllDelegatesUseCase(sl()));


  //Product
  sl.registerLazySingleton(() => AddProductUseCase(sl()));

  sl.registerLazySingleton(() => GetAllProductsUseCase(sl()));

  sl.registerLazySingleton(() => UpdateProductUseCase(sl()));

  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));

  //Unit
  sl.registerLazySingleton(() => AddUnitUseCase(sl()));

  sl.registerLazySingleton(() => GetAllUnitsUseCase(sl()));

  sl.registerLazySingleton(() => UpdateUnitUseCase(sl()));

  sl.registerLazySingleton(() => DeleteUnitUseCase(sl()));

  //Invoice
  sl.registerLazySingleton(() => AddInvoiceUseCase(sl()));

  sl.registerLazySingleton(() => UpdateInvoiceUseCase(sl()));

  sl.registerLazySingleton(() => DeleteInvoiceUseCase(sl()));

  sl.registerLazySingleton(() => GetAllInvoicesUseCase(sl()));

  sl.registerLazySingleton(() => GetInvoiceUseCase(sl()));




  // Cubit
  sl.registerFactory(() => AccountCubit(
    addDealerUseCase: sl(),
    addCustomerUseCase: sl(),
    addDelegateUseCase: sl(),
    updateDealerUseCase: sl(),
    updateCustomerUseCase: sl(),
    updateDelegateUseCase: sl(),
    deleteDealerUseCase:sl() ,
    deleteCustomerUseCase:sl() ,
    deleteDelegateUseCase:sl(),
    getAllDealersUseCase: sl(),
    getAllCustomersUseCase: sl(),
    getAllDelegatesUseCase: sl() ,

  ));

  sl.registerFactory(() => ProductCubit(
      addProductUseCase: sl(),
      deleteProductUseCase: sl(),
      updateProductUseCase: sl(),
      getAllProductsUseCase: sl(),
      addUnitUseCase: sl(),
      getAllUnitsUseCase: sl(),
      updateUnitUseCase: sl(),
      deleteUnitUseCase: sl(),
  ));
  sl.registerFactory(() => InvoiceCubit(
    addInvoiceUseCase:sl(),
    updateInvoiceUseCase: sl(),
    deleteInvoiceUseCase: sl(),
    getAllInvoicesUseCase: sl(),
    getAllDealersUseCase: sl(),
    getAllCustomersUseCase: sl(),
    getAllProductsUseCase: sl(),
    getInvoiceUseCase: sl()));


}
