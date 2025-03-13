import 'package:eks/features/account_management/domain/entities/users_entity.dart';
import 'package:eks/features/account_management/domain/repositories/accounts_repository.dart';

class UpdateDelegateUseCase{
  final AccountsRepository repository;
  UpdateDelegateUseCase(this.repository);
  Future<List<dynamic>> call(Users user)async{
    return await repository.updateDelegate(user) ;
  }
}