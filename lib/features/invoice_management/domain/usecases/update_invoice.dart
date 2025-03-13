import 'package:eks/features/invoice_management/data/models/invoice_items_model.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_entity.dart';
import 'package:eks/features/invoice_management/domain/repositories/invoice_repository.dart';

class UpdateInvoiceUseCase{
  final InvoiceRepository repository;

  UpdateInvoiceUseCase(this.repository);
  Future<List<dynamic>> call(Invoice invoice,List<InvoiceItemsModel> items)async{
    return await repository.updateInvoice(invoice,items) ;
  }
}