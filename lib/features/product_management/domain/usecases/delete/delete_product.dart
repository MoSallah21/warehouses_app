import 'package:eks/features/product_management/domain/repositories/product_repository.dart';

class DeleteProductUseCase{
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);
  Future<List<dynamic>> call(int id)async{
    return await repository.deleteProduct(id) ;
  }
}