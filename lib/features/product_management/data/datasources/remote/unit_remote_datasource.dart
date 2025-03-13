import 'dart:convert';
import 'package:eks/core/constants/server_constants.dart';
import 'package:eks/features/product_management/data/models/unit_model.dart';
import 'package:eks/features/product_management/domain/entities/unit_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class UnitRemoteDatasource{
  Future<List<dynamic>> addUnit( UnitModel unit);

  Future<List<dynamic>> deleteUnit(int id);

  Future<List<dynamic>> updateUnit(UnitModel unit);

  Future<List<Unit>> getAllUnits();
}
class UnitRemoteDatasourceImp extends UnitRemoteDatasource{
  final http.Client client;

  UnitRemoteDatasourceImp({required this.client});

  @override
  Future<List<dynamic>> addUnit(UnitModel unit) async {
    final body = json.encode({
      "unit":unit.type
    });
    final response = await client.post(
      Uri.parse(ServerConstants.serverURL+ServerConstants.unitURL),
      body: body,
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['state'] == 'success') {
        debugPrint(jsonResponse['state']);
        return [];
      }
      else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        return errors.entries
            .map((entry) => {'field': entry.key, 'message': entry.value})
            .toList();
      }
      else {
        return Future.error('Failed to add product');
      }
    } else {
      return Future.error('Failed to add product');
    }
  }

  @override
  Future<List<dynamic>> updateUnit(UnitModel unit) async {
    final body = json.encode({
      "id":unit.id,
      "type":unit.type
    });
    final response = await client.patch(
      Uri.parse(ServerConstants.serverURL+ServerConstants.unitURL),
      body: body,
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['state'] == 'success') {
        debugPrint(jsonResponse['state']);
        return [];
      }
      else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        return errors.entries
            .map((entry) => {'field': entry.key, 'message': entry.value})
            .toList();
      }
      else {
        return Future.error('Failed to add product');
      }
    } else {
      return Future.error('Failed to add product');
    }
  }
  @override
  Future<List<dynamic>> deleteUnit(int id) async {
    final body = json.encode({
      "id": id
    });
    final response = await client.delete(
      Uri.parse(ServerConstants.serverURL+ServerConstants.unitURL),
      body: body,
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['state'] == 'success') {
        debugPrint(jsonResponse['state']);
        return [];
      }
      else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        return errors.entries
            .map((entry) => {'field': entry.key, 'message': entry.value})
            .toList();
      }
      else {
        return Future.error('Failed to get delete unit');
      }
    } else {
      return Future.error('Failed to get delete unit');
    }

  }

  @override
  Future<List<UnitModel>> getAllUnits() async {
    final response = await client.get(
      Uri.parse(ServerConstants.serverURL +ServerConstants.unitURL),
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      final List unitsList = decodedJson['data'] as List;
      final List<UnitModel> units = unitsList
          .map<UnitModel>(
              (jsonUnitModel) => UnitModel.fromJson(jsonUnitModel))
          .toList();
      return units;
    } else {
      return Future.error('Failed to get get products');
    }
  }




}