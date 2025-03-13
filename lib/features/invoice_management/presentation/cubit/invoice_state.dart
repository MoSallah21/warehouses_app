part of 'invoice_cubit.dart';
abstract class InvoiceState{}

class InvoiceInitState extends InvoiceState{}

class AddOrUpdateInvoiceLoadingState extends InvoiceState {}

class AddOrUpdateInvoiceSuccessState extends InvoiceState {}

class AddOrUpdateInvoiceFailureState extends InvoiceState {
  final String error;
  AddOrUpdateInvoiceFailureState(this.error);
}

class AddOrUpdateInvoiceErrorState extends InvoiceState {
  final List<dynamic> errors;
  AddOrUpdateInvoiceErrorState(this.errors);
}

class DeleteInvoiceLoadingState extends InvoiceState {}

class DeleteInvoiceSuccessState extends InvoiceState {}

class DeleteInvoiceFailureState extends InvoiceState {
  final String error;
  DeleteInvoiceFailureState(this.error);
}

class DeleteInvoiceErrorState extends InvoiceState {
  final List<dynamic> errors;
  DeleteInvoiceErrorState(this.errors);
}

class GetAllInvoicesLoadingState extends InvoiceState {}

class GetAllInvoicesSuccessState extends InvoiceState {
  final List<Invoice> invoices;
  GetAllInvoicesSuccessState(this.invoices);
}

class GetAllInvoicesFailureState extends InvoiceState {
  final String error;
  GetAllInvoicesFailureState(this.error);
}
class GetInvoiceLoadingState extends InvoiceState {}

class GetInvoiceSuccessState extends InvoiceState {
  final List<InvoiceItems> invoiceItems;
  GetInvoiceSuccessState(this.invoiceItems);
}

class GetInvoiceFailureState extends InvoiceState {
  final String error;
  GetInvoiceFailureState(this.error);
}

