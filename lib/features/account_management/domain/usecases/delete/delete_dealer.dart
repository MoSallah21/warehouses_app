import 'package:eks/features/account_management/domain/repositories/accounts_repository.dart';

class DeleteDealerUseCase{
  final AccountsRepository repository;

  DeleteDealerUseCase(this.repository);
  Future<List<dynamic>> call(int id)async{
    return await repository.deleteDealer(id) ;
  }
}