import 'package:eks/core/network/local/remote/network_info.dart';
import 'package:eks/features/product_management/data/datasources/remote/unit_remote_datasource.dart';
import 'package:eks/features/product_management/data/models/unit_model.dart';
import 'package:eks/features/product_management/domain/entities/unit_entity.dart';
import 'package:eks/features/product_management/domain/repositories/unit_repository.dart';

 class UnitRepositoryImp extends UnitRepository {
   final UnitRemoteDatasource remoteDatasource;
   final NetworkInfo networkInfo;
   UnitRepositoryImp({required this.remoteDatasource, required this.networkInfo});
   @override
   Future<List<dynamic>> addUnit(Unit unit) async {
     if (await networkInfo.isConnected) {
       final UnitModel unitModel = UnitModel(
           type: unit.type,
       );
       try {
         return await remoteDatasource.addUnit(unitModel);
       } catch (error) {
         return Future.error('Failed to add unit: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }
   @override
   Future<List<dynamic>> updateUnit(Unit unit)async {
     if (await networkInfo.isConnected) {
       final UnitModel unitModel = UnitModel(
           id:unit.id,
           type:unit.type
       );
       try {
         return await remoteDatasource.updateUnit(unitModel);
       } catch (error) {
         return Future.error('Failed to update unit: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }
   @override
   Future<List<dynamic>> deleteUnit(int id) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDatasource.deleteUnit(id);
      } catch (error) {
        return Future.error('Failed to delete unit: $error');
      }
    } else {
      return Future.error('No internet connection');
    }
  }

   @override
   Future<List<Unit>> getAllUnits() async {
     if (true) {
       try {
         return await remoteDatasource.getAllUnits();
       } catch (error) {
         return Future.error('Failed to get all units: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }




}