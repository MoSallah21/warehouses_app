import 'package:eks/features/invoice_management/data/models/invoice_items_model.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_entity.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_items_entity.dart';

abstract class InvoiceRepository{
  Future<List<dynamic>> addInvoice(Invoice invoice);
  Future<List<dynamic>> updateInvoice(Invoice invoice,List<InvoiceItemsModel> invoiceItemsModel);
  Future<List<dynamic>> deleteInvoice(int id);
  Future<List<InvoiceItems>> getInvoice(int id);
  Future<List<Invoice>> getAllInvoices();
}