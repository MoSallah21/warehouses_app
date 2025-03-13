import 'package:eks/features/account_management/domain/entities/users_entity.dart';
import 'package:eks/features/account_management/domain/repositories/accounts_repository.dart';

class AddDealerUseCase{
  final AccountsRepository repository;

  AddDealerUseCase(this.repository);
  Future<List<dynamic>> call(Users users)async{
    return await repository.addDealer(users) ;
  }
}