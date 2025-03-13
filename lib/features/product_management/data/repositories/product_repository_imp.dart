import 'package:eks/core/network/local/remote/network_info.dart';
import 'package:eks/features/product_management/data/datasources/remote/product_remote_datasource.dart';
import 'package:eks/features/product_management/data/models/product_model.dart';
import 'package:eks/features/product_management/domain/entities/product_entity.dart';
import 'package:eks/features/product_management/domain/repositories/product_repository.dart';

 class ProductsRepositoryImp extends ProductRepository {
   final ProductRemoteDatasource remoteDatasource;
   final NetworkInfo networkInfo;
   ProductsRepositoryImp({required this.remoteDatasource, required this.networkInfo});
   @override
   Future<List<dynamic>> addProduct(Product product) async {
     if (await networkInfo.isConnected) {
       final ProductModel productModel = ProductModel(
           name: product.name,
           code: product.code,
           unit: product.unit,
           quantity: product.quantity,
           price: product.price
       );
       try {
         return await remoteDatasource.addProduct(productModel);
       } catch (error) {
         return Future.error('Failed to add product: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }
   @override
   Future<List<dynamic>> updateProduct(Product product)async {
     if (await networkInfo.isConnected) {
       final ProductModel productModel = ProductModel(
           id:product.id,
           name: product.name,
           code: product.code,
           unit: product.unit,
           quantity: product.quantity,
           price: product.price
       );
       try {
         return await remoteDatasource.updateProduct(productModel);
       } catch (error) {
         return Future.error('Failed to update product: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }
   @override
   Future<List<dynamic>> deleteProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDatasource.deleteProduct(id);
      } catch (error) {
        return Future.error('Failed to delete product: $error');
      }
    } else {
      return Future.error('No internet connection');
    }
  }
   @override
   Future<List<Product>> getAllProduct() async {
     if (await networkInfo.isConnected) {
       try {
         return await remoteDatasource.getAllProducts();
       } catch (error) {
         return Future.error('Failed to get all products: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }




}