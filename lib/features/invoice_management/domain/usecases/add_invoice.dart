import 'package:eks/features/invoice_management/domain/entities/invoice_entity.dart';
import 'package:eks/features/invoice_management/domain/repositories/invoice_repository.dart';

class AddInvoiceUseCase{
  final InvoiceRepository repository;

  AddInvoiceUseCase(this.repository);
  Future<List<dynamic>> call(Invoice invoice)async{
    return await repository.addInvoice(invoice) ;
  }
}