import 'package:eks/features/account_management/data/models/account_type.dart';
import 'package:eks/features/account_management/domain/entities/users_entity.dart';
import 'package:eks/features/account_management/domain/usecases/get/get_all_customers.dart';
import 'package:eks/features/account_management/domain/usecases/get/get_all_dealers.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_entity.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_items_entity.dart';
import 'package:eks/features/invoice_management/domain/usecases/add_invoice.dart';
import 'package:eks/features/invoice_management/domain/usecases/delete_invoice.dart';
import 'package:eks/features/invoice_management/domain/usecases/get_all_invoices.dart';
import 'package:eks/features/invoice_management/domain/usecases/get_invoice.dart';
import 'package:eks/features/invoice_management/domain/usecases/update_invoice.dart';
import 'package:eks/features/product_management/domain/entities/product_entity.dart';
import 'package:eks/features/product_management/domain/usecases/get/get_all_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final AddInvoiceUseCase addInvoiceUseCase;
  final UpdateInvoiceUseCase updateInvoiceUseCase;
  final DeleteInvoiceUseCase deleteInvoiceUseCase;
  final GetAllInvoicesUseCase getAllInvoicesUseCase;
  final GetInvoiceUseCase getInvoiceUseCase;
  final GetAllDealersUseCase getAllDealersUseCase;
  final GetAllCustomersUseCase getAllCustomersUseCase;
  final GetAllProductsUseCase getAllProductsUseCase;



  InvoiceCubit({required this.addInvoiceUseCase, required this.updateInvoiceUseCase,required this.deleteInvoiceUseCase,required this.getAllInvoicesUseCase,required this.getAllDealersUseCase,required this.getAllCustomersUseCase,required this.getAllProductsUseCase,required this.getInvoiceUseCase}): super(InvoiceInitState());

  static InvoiceCubit get(context) => BlocProvider.of(context);

  Future<void> deleteInvoice(int id) async {
    // emit(DeleteProductOrUnitLoadingState());

    try {
      final result = await deleteInvoiceUseCase.call(id);

      if (result.isEmpty) {
        // emit(DeleteProductOrUnitSuccessState());
      } else {
        // emit(DeleteProductOrUnitErrorState(result));
      }
    } catch (error) {
      // emit(DeleteProductOrUnitFailureState(error.toString()));
    }
  }

  List<Invoice> invoices = [];

  Future<List<Invoice>> getAllInvoices(String invoiceType) async {
    emit(GetAllInvoicesLoadingState());
    try {
      final List<Invoice> result = await getAllInvoicesUseCase.call();
      invoices = result.where((invoice) => invoice.invoiceType == invoiceType).toList();
      emit(GetAllInvoicesSuccessState(invoices));
      return invoices;
    } catch (error) {
      emit(GetAllInvoicesFailureState(error.toString()));
      return [];
    }
  }

  List<InvoiceItems> invoiceItems = [];
  Future<List<InvoiceItems>> getInvoice(int id) async {
    emit(GetInvoiceLoadingState());
    try {
      final result = await getInvoiceUseCase.call(id);
      invoiceItems = result;
      emit(GetInvoiceSuccessState(invoiceItems));
      return invoiceItems;
    } catch (error) {
      emit(GetInvoiceFailureState(error.toString()));
      return [];
    }
  }

  List<Users> dealers=[];
  List<Users> customers=[];
  Future<List<Users>> getAllDealersOrCustomers(AccountType accountType) async {
    late final List<Users> result;
    try {
      if(accountType==AccountType.dealer){
        result = await getAllDealersUseCase.call();
        dealers=result;
        return dealers;
      }
      else{
        result = await getAllCustomersUseCase.call();
        customers=result;
        return customers;
      }
    } catch (error) {
      return [];
    }
  }
  List<Product> products = [];
  Future<List<Product>> getAllProducts() async {
    late final List<Product> result;
    try {
       result = await getAllProductsUseCase.call();
      products = result;
      return products;
    } catch (error) {
      return [];
    }
  }
  Future<void> addInvoice(Invoice invoice) async {
    emit(AddOrUpdateInvoiceLoadingState());
    try {
      final result = await addInvoiceUseCase.call(invoice);
      if (result.isEmpty) {
        emit(AddOrUpdateInvoiceSuccessState());
      } else {
        emit(AddOrUpdateInvoiceErrorState(result));
      }
    } catch (error) {
      emit(AddOrUpdateInvoiceFailureState(error.toString()));
    }
  }



}