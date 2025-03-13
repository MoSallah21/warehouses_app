import 'package:eks/features/product_management/domain/entities/product_entity.dart';
import 'package:eks/features/product_management/domain/repositories/product_repository.dart';

class AddProductUseCase{
  final ProductRepository repository;

  AddProductUseCase(this.repository);
  Future<List<dynamic>> call(Product product)async{
    return await repository.addProduct(product) ;
  }
}