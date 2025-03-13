import 'package:eks/features/product_management/domain/entities/unit_entity.dart';
import 'package:eks/features/product_management/domain/repositories/unit_repository.dart';

class GetAllUnitsUseCase{
  final UnitRepository repository;

  GetAllUnitsUseCase(this.repository);
  Future<List<Unit>> call()async{
    return await repository.getAllUnits() ;
  }
}