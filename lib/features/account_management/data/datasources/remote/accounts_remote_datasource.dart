import 'dart:convert';
import 'package:eks/core/constants/server_constants.dart';
import 'package:eks/core/errors/exception.dart';
import 'package:eks/features/account_management/data/models/users_model.dart';
import 'package:http/http.dart' as http;

abstract class AccountsRemoteDatasource{
  Future<List<dynamic>> addDealer(UsersModel user);
  Future<List<dynamic>> addCustomer(UsersModel user);
  Future<List<dynamic>> addDelegate(UsersModel user);
  Future<List<dynamic>> updateDealer(UsersModel user);
  Future<List<dynamic>> updateCustomer(UsersModel user);
  Future<List<dynamic>> updateDelegate(UsersModel user);
  Future<List<dynamic>> deleteDealer(int id);
  Future<List<dynamic>> deleteCustomer(int id);
  Future<List<dynamic>> deleteDelegate(int id);
  Future<List<UsersModel>> getAllDealers();
  Future<List<UsersModel>> getAllCustomers();
  Future<List<UsersModel>> getAllDelegates();


}
class AccountsRemoteDatasourceImp extends AccountsRemoteDatasource{
  final http.Client client;

  AccountsRemoteDatasourceImp({required this.client});


  @override
  Future<List<dynamic>> addDealer(UsersModel user) async {
    final body = json.encode({
      "username": user.username,
      "address": user.address,
      "phone": user.phone,
      "administrator_name": user.administratorName,
      "administrator_phone": user.administratorPhone,
    });
      final response = await client.post(
        Uri.parse(ServerConstants.serverURL + ServerConstants.dealerURL),
        body: body,
        headers: ServerConstants.headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['state'] == 'success') {
          print(jsonResponse['state']);
          return [];
        }

        // Handle the 'not success' state with errors
        else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
          final errors = jsonResponse['errors'] as Map<String, dynamic>;
          return errors.entries
              .map((entry) => {'field': entry.key, 'message': entry.value})
              .toList();  // Return a list of error messages
        }

        else {
          throw ServerException();  // Handle unexpected states
        }
      } else {
        throw ServerException();
      }

  }
  @override
  Future<List<dynamic>> addCustomer(UsersModel user) async {
    print('x');

    final body = json.encode({
      "username": user.username,
      "address": user.address,
      "phone": user.phone,
      "administrator_name": user.administratorName,
      "administrator_phone": user.administratorPhone,
    });
      final response = await client.post(
        Uri.parse(ServerConstants.serverURL + ServerConstants.customerURL),
        body: body,
        headers: ServerConstants.headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['state'] == 'success') {
          print(jsonResponse['state']);
          return [];
        }
        else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
          final errors = jsonResponse['errors'] as Map<String, dynamic>;
          return errors.entries
              .map((entry) => {'field': entry.key, 'message': entry.value})
              .toList();  // Return a list of error messages
        }

        else {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    }
  @override
  Future<List<dynamic>> addDelegate(UsersModel user) async {
    final body = json.encode({
      "username": user.username,
      "password": user.password,
    });

    final response = await client.post(
      Uri.parse(ServerConstants.serverURL+ServerConstants.delegateURL),
      body: body,
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['state'] == 'success') {
        print(jsonResponse['state']);
        return [];
      }
      else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        return errors.entries
            .map((entry) => {'field': entry.key, 'message': entry.value})
            .toList();
      }
      else {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        return errors.entries
            .map((entry) => {'field': entry.key, 'message': entry.value})
            .toList();
      }
    } else {
      throw ServerException();
    }
  }
  @override
  Future<List<dynamic>> updateDealer(UsersModel user) async {
    final body = json.encode({
      "id":user.id,
      "username": user.username,
      "address": user.address,
      "phone": user.phone,
      "administrator_name": user.administratorName,
      "administrator_phone": user.administratorPhone,
    });

      final response = await client.patch(
        Uri.parse(ServerConstants.serverURL + ServerConstants.dealerURL),
        body: body,
        headers: ServerConstants.headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['state'] == 'success') {
          print(jsonResponse['state']);
          return [];
        }

        else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
          final errors = jsonResponse['errors'] as Map<String, dynamic>;
          return errors.entries
              .map((entry) => {'field': entry.key, 'message': entry.value})
              .toList();  // Return a list of error messages
        }
        else {
          throw ServerException();  // Handle unexpected states
        }
      } else {
        throw ServerException();
      }
    }
  @override
  Future<List<dynamic>> updateCustomer(UsersModel user) async {
    final body = json.encode({
      "id":user.id,
      "username": user.username,
      "address": user.address,
      "phone": user.phone,
      "administrator_name": user.administratorName,
      "administrator_phone": user.administratorPhone,
    });
      final response = await client.patch(
        Uri.parse(ServerConstants.serverURL +ServerConstants.customerURL),
        body: body,
        headers: ServerConstants.headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['state'] == 'success') {
          print(jsonResponse['state']);
          return [];
        }
        else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
          final errors = jsonResponse['errors'] as Map<String, dynamic>;
          return errors.entries
              .map((entry) => {'field': entry.key, 'message': entry.value})
              .toList();  // Return a list of error messages
        }

        else {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }

  }
  @override
  Future<List<dynamic>> updateDelegate(UsersModel user) async {
    final body = json.encode({
      "id":user.id,
      "username": user.username,
      "password": user.password,
    });

    final response = await client.patch(
      Uri.parse(ServerConstants.serverURL+ServerConstants.delegateURL),
      body: body,
      headers: ServerConstants.headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['state'] == 'success') {
        print(jsonResponse['state']);
        return [];
      }
      else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        return errors.entries
            .map((entry) => {'field': entry.key, 'message': entry.value})
            .toList();
      }
      else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
  @override
  Future<List<dynamic>> deleteDealer(int id) async{
    final body = json.encode({
      "id": id,
    });
    final response = await client.delete(
      Uri.parse(ServerConstants.serverURL+ServerConstants.dealerURL),
      body: body,
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['state'] == 'success') {
        print(jsonResponse['state']);
        return [];
      }
      else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        return errors.entries
            .map((entry) => {'field': entry.key, 'message': entry.value})
            .toList();
      }
      else {
        throw ServerException();  // Handle unexpected states
      }
    } else {
      throw ServerException();
    }
  }
  @override
  Future<List<dynamic>> deleteCustomer(int id) async{
    final body = json.encode({
      "id": id,
    });
    final response = await client.delete(
      Uri.parse(ServerConstants.serverURL+ServerConstants.customerURL),
      body: body,
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['state'] == 'success') {
        print(jsonResponse['state']);
        return [];
      }
      else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        return errors.entries
            .map((entry) => {'field': entry.key, 'message': entry.value})
            .toList();
      }
      else {
        throw ServerException();  // Handle unexpected states
      }
    } else {
      throw ServerException();
    }
  }
  @override
  Future<List<dynamic>> deleteDelegate(int id) async{
    final body = json.encode({
      "id": id,
    });
    final response = await client.delete(
      Uri.parse(ServerConstants.serverURL+ServerConstants.delegateURL),
      body: body,
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['state'] == 'success') {
        print(jsonResponse['state']);
        return [];
      }
      else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        return errors.entries
            .map((entry) => {'field': entry.key, 'message': entry.value})
            .toList();
      }
      else {
        throw ServerException();  // Handle unexpected states
      }
    } else {
      throw ServerException();
    }
  }
  @override
  Future<List<UsersModel>> getAllDealers() async {
    final response = await client.get(
      Uri.parse(ServerConstants.serverURL + ServerConstants.dealerURL),
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final List<dynamic> data = decodedJson['data'];
      final List<UsersModel> users = data
          .map<UsersModel>((jsonUserModel) => UsersModel.fromJson(jsonUserModel))
          .toList();
      print(users);

      return users;
    } else {
      throw ServerException();
    }
  }
  @override
  Future<List<UsersModel>> getAllCustomers() async {
    final response = await client.get(
      Uri.parse(ServerConstants.serverURL + ServerConstants.customerURL),
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final List<dynamic> data = decodedJson['data'];
      final List<UsersModel> users = data
          .map<UsersModel>((jsonUserModel) => UsersModel.fromJson(jsonUserModel))
          .toList();
      return users;
    } else {
      throw ServerException();
    }
  }
  @override
  Future<List<UsersModel>> getAllDelegates() async {
    final response = await client.get(
      Uri.parse(ServerConstants.serverURL + ServerConstants.delegateURL),
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final List<dynamic> data = decodedJson['data'];
      final List<UsersModel> users = data
          .map<UsersModel>((jsonUserModel) => UsersModel.fromJson(jsonUserModel))
          .toList();
      return users;
    } else {
      throw ServerException();
    }
  }

}