import 'package:eks/features/product_management/domain/entities/unit_entity.dart';
import 'package:eks/features/product_management/domain/repositories/unit_repository.dart';

class UpdateUnitUseCase{
  final UnitRepository repository;

  UpdateUnitUseCase(this.repository);
  Future<List<dynamic>> call(Unit unit)async{
    return await repository.updateUnit(unit) ;
  }
}