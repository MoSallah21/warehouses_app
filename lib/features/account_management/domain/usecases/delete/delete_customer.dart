import 'package:eks/features/account_management/domain/repositories/accounts_repository.dart';

class DeleteCustomerUseCase{
  final AccountsRepository repository;

  DeleteCustomerUseCase(this.repository);
  Future<List<dynamic>> call(int id)async{
    return await repository.deleteCustomer(id) ;
  }
}