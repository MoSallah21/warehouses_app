import 'package:eks/features/invoice_management/domain/entities/invoice_entity.dart';
import 'package:eks/features/invoice_management/domain/repositories/invoice_repository.dart';

class GetAllInvoicesUseCase{
  final InvoiceRepository repository;

  GetAllInvoicesUseCase(this.repository);
  Future<List<Invoice>> call()async{
    return await repository.getAllInvoices() ;
  }
}