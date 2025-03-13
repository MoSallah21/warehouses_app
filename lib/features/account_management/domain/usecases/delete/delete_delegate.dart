import 'package:eks/features/account_management/domain/repositories/accounts_repository.dart';

class DeleteDelegateUseCase{
  final AccountsRepository repository;
  DeleteDelegateUseCase(this.repository);
  Future<List<dynamic>> call(int id)async{
    return await repository.deleteDelegate(id) ;
  }
}