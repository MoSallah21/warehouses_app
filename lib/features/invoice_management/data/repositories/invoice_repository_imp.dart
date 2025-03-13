import 'package:eks/core/network/local/remote/network_info.dart';
import 'package:eks/features/invoice_management/data/datasources/remote/invoice_remote_datasource.dart';
import 'package:eks/features/invoice_management/data/models/invoice_items_model.dart';
import 'package:eks/features/invoice_management/data/models/invoice_model.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_entity.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_items_entity.dart';
import 'package:eks/features/invoice_management/domain/repositories/invoice_repository.dart';

class InvoiceRepositoryImp extends InvoiceRepository {
  final InvoiceRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;
  InvoiceRepositoryImp({required this.remoteDatasource, required this.networkInfo});

  @override
  Future<List<dynamic>> addInvoice(Invoice invoice) async {
    if (await networkInfo.isConnected) {
      final InvoiceModel invoiceModel = InvoiceModel(
          date: invoice.date,
          number: invoice.number,
          invoiceType: invoice.invoiceType,
          clientName: invoice.clientName,
          items: invoice.items,
          totalPrice: invoice.totalPrice,
        );
      try {
        return await remoteDatasource.addInvoice(invoiceModel);
      } catch (error) {
        return Future.error('Failed to add product: $error');
      }
    } else {
      return Future.error('No internet connection');
    }
  }
  @override
  Future<List<dynamic>> updateInvoice(Invoice invoice,List<InvoiceItemsModel> invoiceItemsModel) async {
    if (await networkInfo.isConnected) {
      final InvoiceModel invoiceModel = InvoiceModel(
        id: invoice.id,
        date: invoice.date,
        number: invoice.number,
        invoiceType: invoice.invoiceType,
        clientName: invoice.clientName,
        items: invoiceItemsModel,
        totalPrice: invoice.totalPrice,
      );
      try {
        return await remoteDatasource.updateInvoice(invoiceModel);
      } catch (error) {
        return Future.error('Failed to add product: $error');
      }
    } else {
      return Future.error('No internet connection');
    }
  }
  @override
  Future<List<dynamic>> deleteInvoice(int id) async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDatasource.deleteInvoice(id);
      } catch (error) {
        return Future.error('Failed to delete product: $error');
      }
    } else {
      return Future.error('No internet connection');
    }
  }
  @override
  Future<List<Invoice>> getAllInvoices() async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDatasource.getAllInvoices();
      } catch (error) {
        return Future.error('Failed to get all invoices: $error');
      }
    } else {
      return Future.error('No internet connection');
    }
  }
  @override
  Future<List<InvoiceItems>> getInvoice(int id)async {
    if (await networkInfo.isConnected) {
      try {
        return await remoteDatasource.getInvoice(id);
      } catch (error) {
        return Future.error('Failed to get invoice items: $error');
      }
    } else {
      return Future.error('No internet connection');
    }
  }
}