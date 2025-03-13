import 'dart:convert';
import 'package:eks/core/constants/server_constants.dart';
import 'package:eks/core/errors/exception.dart';
import 'package:eks/features/invoice_management/data/models/invoice_items_model.dart';
import 'package:eks/features/invoice_management/data/models/invoice_model.dart';
import 'package:http/http.dart' as http;

abstract class InvoiceRemoteDatasource{
  Future<List<dynamic>> addInvoice(InvoiceModel listOfInvoice);
  Future<List<dynamic>> updateInvoice(InvoiceModel invoice);
  Future<List<dynamic>> deleteInvoice(int id);
  Future<List<InvoiceItemsModel>> getInvoice(int id);
  Future<List<InvoiceModel>> getAllInvoices();


}
class InvoiceRemoteDatasourceImp extends InvoiceRemoteDatasource{
  final http.Client client;

  InvoiceRemoteDatasourceImp({required this.client});

  @override
  Future<List<dynamic>> addInvoice(InvoiceModel listOfInvoice) async {
    final body = json.encode({
      "date":listOfInvoice.date,
      "number": listOfInvoice.number,
      "invoice_type":listOfInvoice.invoiceType,
      "name": listOfInvoice.clientName,
      "items":listOfInvoice.items,
      "total_price":listOfInvoice.totalPrice,
    });
    final response = await client.post(
      Uri.parse(ServerConstants.serverURL + ServerConstants.invoiceURL),
      body: body,
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['state'] == 'success') {
        print(jsonResponse['state']);
        return [];
      } else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        return errors.entries
            .map((entry) => {'field': entry.key, 'message': entry.value})
            .toList();
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
  @override
  Future<List<dynamic>> updateInvoice(InvoiceModel invoice) async {
    final body = json.encode({
      "id":invoice.id,
      "date":invoice.date,
      "number": invoice.number,
      "invoiceType":invoice.invoiceType,
      "name": invoice.clientName,
      "items": invoice.items,
      "total_price":invoice.totalPrice,
    });
    final response = await client.patch(
      Uri.parse(ServerConstants.serverURL + ServerConstants.invoiceURL),
      body: body,
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['state'] == 'success') {
        print(jsonResponse['state']);
        return [];
      } else if (jsonResponse['state'] == 'not success' && jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as Map<String, dynamic>;
        return errors.entries
            .map((entry) => {'field': entry.key, 'message': entry.value})
            .toList();
      } else {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
  @override
  Future<List<dynamic>> deleteInvoice(int id) async{
    final body = json.encode({
      "id": id,
    });
    final response = await client.delete(
      Uri.parse(ServerConstants.serverURL+ServerConstants.invoiceURL),
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
  Future<List<InvoiceItemsModel>> getInvoice(int id) async {
    final response = await client.get(
      Uri.parse('${ServerConstants.serverURL}${ServerConstants.invoiceURL}?id=$id'),
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final List<dynamic> data = decodedJson['data'];
      final List<InvoiceItemsModel> invoiceItem = data
          .map<InvoiceItemsModel>((jsonInvoiceModel) => InvoiceItemsModel.fromJson(jsonInvoiceModel))
          .toList();
      return invoiceItem;
        } else {
      throw ServerException();
    }
  }

  @override
  Future<List<InvoiceModel>> getAllInvoices() async {
    final response = await client.get(
      Uri.parse(ServerConstants.serverURL + ServerConstants.invoicesURL),
      headers: ServerConstants.headers,
    );
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final List<dynamic> data = decodedJson['data'];
      final List<InvoiceModel> invoice = data
          .map<InvoiceModel>((jsonInvoiceModel) => InvoiceModel.fromJson(jsonInvoiceModel))
          .toList();
      print(invoice);
      return invoice;
    } else {
      throw ServerException();
    }
  }

}