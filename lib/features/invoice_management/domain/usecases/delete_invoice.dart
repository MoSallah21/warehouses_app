import 'package:eks/features/invoice_management/domain/repositories/invoice_repository.dart';

class DeleteInvoiceUseCase{
  final InvoiceRepository repository;

  DeleteInvoiceUseCase(this.repository);
  Future<List<dynamic>> call(int id)async{
    return await repository.deleteInvoice(id) ;
  }
}