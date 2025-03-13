import 'package:eks/features/product_management/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<dynamic>> addProduct(Product product);

  Future<List<dynamic>> deleteProduct(int id);

  Future<List<dynamic>> updateProduct(Product product);

  Future<List<Product>> getAllProduct();




}