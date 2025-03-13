import 'package:eks/features/account_management/domain/entities/users_entity.dart';
import 'package:eks/features/account_management/domain/repositories/accounts_repository.dart';

class AddCustomerUseCase{
  final AccountsRepository repository;

  AddCustomerUseCase(this.repository);
  Future<List<dynamic>> call(Users users)async{
    print('Customer usecase');
    return await repository.addCustomer(users) ;
  }
}