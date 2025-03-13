import 'package:eks/features/product_management/domain/entities/product_entity.dart';
import 'package:eks/features/product_management/domain/repositories/product_repository.dart';

class GetAllProductsUseCase{
  final ProductRepository repository;

  GetAllProductsUseCase(this.repository);
  Future<List<Product>> call()async{
    return await repository.getAllProduct() ;
  }
}