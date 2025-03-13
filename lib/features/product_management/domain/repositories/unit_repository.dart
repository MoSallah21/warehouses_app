import 'package:eks/features/product_management/domain/entities/unit_entity.dart';

abstract class UnitRepository {
  Future<List<dynamic>> addUnit( Unit unit);

  Future<List<dynamic>> deleteUnit(int id);

  Future<List<dynamic>> updateUnit(Unit unit);

  Future<List<Unit>> getAllUnits();




}