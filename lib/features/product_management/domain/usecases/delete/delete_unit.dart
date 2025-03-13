import 'package:eks/features/product_management/domain/repositories/unit_repository.dart';

class DeleteUnitUseCase{
  final UnitRepository repository;

  DeleteUnitUseCase(this.repository);
  Future<List<dynamic>> call(int id)async{
    return await repository.deleteUnit(id) ;
  }
}