import 'package:eks/features/invoice_management/domain/entities/invoice_items_entity.dart';
import 'package:eks/features/invoice_management/domain/repositories/invoice_repository.dart';

class GetInvoiceUseCase{
  final InvoiceRepository repository;

  GetInvoiceUseCase(this.repository);
  Future<List<InvoiceItems>> call(int id)async{
    return await repository.getInvoice(id) ;
  }
}