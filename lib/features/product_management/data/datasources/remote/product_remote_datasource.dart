import 'dart:convert';
import 'package:eks/core/constants/server_constants.dart';
import 'package:eks/features/product_management/data/models/product_model.dart';
import 'package:eks/features/product_management/domain/entities/product_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDatasource{
  Future<List<dynamic>> addProduct(Product product);

  Future<List<dynamic>> updateProduct(Product product);

  Future<List<dynamic>> deleteProduct(int id);

  Future<List<ProductModel>> getAllProducts();
}
class ProductRemoteDatasourceImp extends ProductRemoteDatasource{
  final http.Client client;

  ProductRemoteDatasourceImp({required this.client});

  @override
  Future<List<dynamic>> addProduct(Product product) async {
    final body = json.encode({
      "name": product.name,
      "code":product.code,
      "quantity": product.quantity,
      "price": product.price,
      "unit":product.unit
    });
    final response = await client.post(
      Uri.parse(ServerConstants.serverURL+ServerConstants.productURL),
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
  Future<List<dynamic>> updateProduct(Product product) async {
    final body = json.encode({
      "id":product.id,
      "name": product.name,
      "code":product.code,
      "unit":product.unit,
      "quantity": product.quantity,
      "price": product.price,
    });
    final response = await client.patch(
      Uri.parse(ServerConstants.serverURL+ServerConstants.productURL),
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
        return Future.error('Failed to get update product');

      }
    } else {
      return Future.error('Failed to get update product');
    }
  }

  @override
  Future<List> deleteProduct(int id) async {
    final body = json.encode({
      "id": id
    });
    final response = await client.delete(
      Uri.parse(ServerConstants.serverURL+ServerConstants.productURL),
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
        return Future.error('Failed to get delete product');
      }
    } else {
      return Future.error('Failed to get delete product');
    }

  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(
      Uri.parse(ServerConstants.serverURL +ServerConstants.productURL),
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      final List productList = decodedJson['data'] as List;
      final List<ProductModel> products = productList
          .map<ProductModel>(
              (jsonProductModel) => ProductModel.fromJson(jsonProductModel))
          .toList();
      return products;
    } else {
      return Future.error('Failed to get get products');
    }
  }




}