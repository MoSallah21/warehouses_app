import 'package:eks/features/account_management/domain/entities/users_entity.dart';

abstract class AccountsRepository {
  Future<List<dynamic>> addDealer(Users user);
  Future<List<dynamic>> addCustomer(Users user);
  Future<List<dynamic>> addDelegate(Users user);
  Future<List<dynamic>> updateDealer(Users user);
  Future<List<dynamic>> updateCustomer(Users user);
  Future<List<dynamic>> updateDelegate(Users user);
  Future<List<dynamic>> deleteDealer(int id);
  Future<List<dynamic>> deleteCustomer(int id);
  Future<List<dynamic>> deleteDelegate(int id);
  Future<List<Users>> getAllDealers();
  Future<List<Users>> getAllCustomers();
  Future<List<Users>> getAllDelegates();

}