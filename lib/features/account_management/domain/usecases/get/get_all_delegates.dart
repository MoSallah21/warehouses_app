import 'package:eks/features/account_management/domain/entities/users_entity.dart';
import 'package:eks/features/account_management/domain/repositories/accounts_repository.dart';

class GetAllDelegatesUseCase{
  final AccountsRepository repository;

  GetAllDelegatesUseCase(this.repository);
  Future<List<Users>> call()async{
    return await repository.getAllDelegates() ;
  }
}