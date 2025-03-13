import 'package:eks/core/network/local/remote/network_info.dart';
import 'package:eks/features/account_management/data/datasources/remote/accounts_remote_datasource.dart';
import 'package:eks/features/account_management/data/models/users_model.dart';
import 'package:eks/features/account_management/domain/entities/users_entity.dart';
import 'package:eks/features/account_management/domain/repositories/accounts_repository.dart';

 class AccountsRepositoryImp extends AccountsRepository {
   final AccountsRemoteDatasource remoteDatasource;
   final NetworkInfo networkInfo;
  AccountsRepositoryImp({required this.remoteDatasource, required this.networkInfo});
   @override
   Future<List<dynamic>> addDealer(Users user) async {
    if (await networkInfo.isConnected) {
      final UsersModel usersModel = UsersModel(
        username: user.username,
        address: user.address,
        phone: user.phone,
        administratorName: user.administratorName,
        administratorPhone: user.administratorPhone,
      );
      try {
        return await remoteDatasource.addDealer(usersModel);
      } catch (error) {
        return Future.error('Failed to add dealer: $error');
      }
    } else {
      return Future.error('No internet connection');
    }
  }
   @override
   Future<List<dynamic>> addCustomer(Users user) async {
     if (await networkInfo.isConnected) {

       final UsersModel usersModel = UsersModel(
         username: user.username,
         address: user.address,
         phone: user.phone,
         administratorName: user.administratorName,
         administratorPhone: user.administratorPhone,
       );
       try {
         return await remoteDatasource.addCustomer(usersModel);
       } catch (error) {
         return Future.error('Failed to add customer: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }
   @override
   Future<List<dynamic>> addDelegate(Users user) async {
    if (await networkInfo.isConnected) {
      final UsersModel usersModel = UsersModel(
        username: user.username,
        password: user.password,
      );
      try {
        return await remoteDatasource.addDelegate(usersModel);
      } catch (error) {
        return Future.error('Failed to add delegate: $error');
      }
    } else {
      return Future.error('No internet connection');
    }
  }
   @override
   Future<List<dynamic>> updateDealer(Users user) async {
     if (await networkInfo.isConnected) {
       final UsersModel usersModel = UsersModel(
         id: user.id,
         username: user.username,
         address: user.address,
         phone: user.phone,
         administratorName: user.administratorName,
         administratorPhone: user.administratorPhone,
       );
       try {
         return await remoteDatasource.updateDealer(usersModel);
       } catch (error) {
         return Future.error('Failed to update dealer: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }
   @override
   Future<List<dynamic>> updateCustomer(Users user)async {
     if (await networkInfo.isConnected) {
       final UsersModel usersModel = UsersModel(
         id: user.id,
         username: user.username,
         address: user.address,
         phone: user.phone,
         administratorName: user.administratorName,
         administratorPhone: user.administratorPhone,
       );
       try {
         return await remoteDatasource.updateCustomer(usersModel);
       } catch (error) {
         return Future.error('Failed to update customer: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }
   @override
   Future<List<dynamic>> updateDelegate(Users user) async {
     if (await networkInfo.isConnected) {
       final UsersModel usersModel = UsersModel(
         id: user.id,
         username: user.username,
         password: user.password,
       );
       try {
         return await remoteDatasource.updateDelegate(usersModel);
       } catch (error) {
         return Future.error('Failed to update delegate: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }
   @override
   Future<List<dynamic>> deleteDealer(int id)async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDatasource.deleteDealer(id);
      } catch (error) {
        return Future.error('Failed to delete dealer: $error');
      }
    } else {
      return Future.error('No internet connection');
    }
  }
   @override
   Future<List<dynamic>> deleteCustomer(int id)async {
     if (await networkInfo.isConnected) {
       try {
         return await remoteDatasource.deleteCustomer(id);
       } catch (error) {
         return Future.error('Failed to delete customer: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }
   @override
   Future<List<dynamic>> deleteDelegate(int id)async {
     if (await networkInfo.isConnected) {
       try {
         return await remoteDatasource.deleteDelegate(id);
       } catch (error) {
         return Future.error('Failed to delete delegate: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }
   @override
   Future<List<Users>> getAllDealers() async {
     if (await networkInfo.isConnected) {
       try {
         final List<UsersModel> userModels = await remoteDatasource.getAllDealers();
         final List<Users> users = userModels.map((model) => Users(
           id: model.id,
           username: model.username,
           address: model.address,
           phone: model.phone,
           password: model.password,
           administratorName: model.administratorName,
           administratorPhone: model.administratorPhone,
           userId: model.userId,
         )).toList();
         return users;
       } catch (error) {
         return Future.error('Failed to get all customers: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }
   @override
   Future<List<Users>> getAllCustomers() async {
     if (await networkInfo.isConnected) {
       try {
         final List<UsersModel> userModels = await remoteDatasource.getAllCustomers();
         final List<Users> users = userModels.map((model) => Users(
           id: model.id,
           username: model.username,
           address: model.address,
           phone: model.phone,
           password: model.password,
           administratorName: model.administratorName,
           administratorPhone: model.administratorPhone,
           userId: model.userId,
         )).toList();
         return users;
       } catch (error) {
         return Future.error('Failed to get all customers: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }

   @override
   Future<List<Users>> getAllDelegates() async {
     if (await networkInfo.isConnected) {
       try {
         final List<UsersModel> userModels = await remoteDatasource.getAllDelegates();
         final List<Users> users = userModels.map((model) => Users(
           id: model.id,
           username: model.username,
           password: model.password,
         )).toList();
         return users;
       } catch (error) {
         return Future.error('Failed to get all customers: $error');
       }
     } else {
       return Future.error('No internet connection');
     }
   }


}