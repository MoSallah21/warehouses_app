import 'package:eks/features/account_management/data/models/account_type.dart';
import 'package:eks/features/account_management/domain/entities/users_entity.dart';
import 'package:eks/features/account_management/domain/usecases/add/add_customer.dart';
import 'package:eks/features/account_management/domain/usecases/add/add_dealer.dart';
import 'package:eks/features/account_management/domain/usecases/add/add_delegate.dart';
import 'package:eks/features/account_management/domain/usecases/delete/delete_customer.dart';
import 'package:eks/features/account_management/domain/usecases/delete/delete_dealer.dart';
import 'package:eks/features/account_management/domain/usecases/delete/delete_delegate.dart';
import 'package:eks/features/account_management/domain/usecases/get/get_all_customers.dart';
import 'package:eks/features/account_management/domain/usecases/get/get_all_dealers.dart';
import 'package:eks/features/account_management/domain/usecases/get/get_all_delegates.dart';
import 'package:eks/features/account_management/domain/usecases/update/update_customer.dart';
import 'package:eks/features/account_management/domain/usecases/update/update_dealer.dart';
import 'package:eks/features/account_management/domain/usecases/update/update_delegate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AddDealerUseCase addDealerUseCase;
  final AddCustomerUseCase addCustomerUseCase;
  final AddDelegateUseCase addDelegateUseCase;
  final UpdateDealerUseCase updateDealerUseCase;
  final UpdateCustomerUseCase updateCustomerUseCase;
  final UpdateDelegateUseCase updateDelegateUseCase;
  final DeleteDealerUseCase deleteDealerUseCase;
  final DeleteCustomerUseCase deleteCustomerUseCase;
  final DeleteDelegateUseCase deleteDelegateUseCase;
  final GetAllDealersUseCase getAllDealersUseCase;
  final GetAllCustomersUseCase getAllCustomersUseCase;
  final GetAllDelegatesUseCase getAllDelegatesUseCase;



  AccountCubit(
      { required this.addDealerUseCase,
        required this.addCustomerUseCase,
        required this.addDelegateUseCase,
        required this.updateDealerUseCase,
        required this.updateCustomerUseCase,
        required this.updateDelegateUseCase,
        required this.deleteDealerUseCase,
        required this.deleteCustomerUseCase,
        required this.deleteDelegateUseCase,
        required this.getAllDealersUseCase,
        required this.getAllCustomersUseCase,
        required this.getAllDelegatesUseCase,

      }) : super(AccountInitState());

  static AccountCubit get(context) => BlocProvider.of(context);


  Future<void> addAccount(Users user,AccountType accountType) async {
    emit(AddOrUpdateAccountLoadingState());
    late final List<dynamic> result;
    try {
      if(accountType==AccountType.dealer){
       result = await addDealerUseCase.call(user);}
      else if(accountType==AccountType.customer){
        result=await addCustomerUseCase.call(user);
      }
      else if(accountType==AccountType.delegate){
        result=await addDelegateUseCase.call(user);
      }

      if (result.isEmpty) {
        emit(AddOrUpdateAccountSuccessState());
      } else {
        emit(AddOrUpdateAccountErrorState(result));
      }

    } catch (error) {
      emit(AddOrUpdateAccountFailureState(error.toString()));
    }
  }

  Future<void> updateAccount(Users user,AccountType accountType) async {
    emit(AddOrUpdateAccountLoadingState());
   late final List<dynamic> result;
    try {
      if(accountType==AccountType.dealer){
         result = await updateDealerUseCase.call(user);
      }
      if(accountType==AccountType.customer){
        result = await updateCustomerUseCase.call(user);
      }
      if(accountType==AccountType.delegate){
        result = await updateDelegateUseCase.call(user);
      }
        if (result.isEmpty) {
          emit(AddOrUpdateAccountSuccessState());
        } else {
          emit(AddOrUpdateAccountErrorState(result));
        }


    } catch (error) {
      emit(AddOrUpdateAccountFailureState(error.toString()));
    }
  }

  Future<void> deleteAccount(int id,AccountType accountType) async {
    emit(DeleteAccountLoadingState());
   late final List<dynamic> result;
    try {
      if(accountType==AccountType.dealer){
       result = await deleteDealerUseCase.call(id);
      }
      else if(accountType==AccountType.customer){
        result = await deleteCustomerUseCase.call(id);}
      else if(accountType==AccountType.delegate){
        result = await deleteDelegateUseCase.call(id);}
      if (result.isEmpty) {
        emit(DeleteAccountSuccessState());
      } else {
        emit(DeleteAccountErrorState(result));
      }
    } catch (error) {
      emit(DeleteAccountFailureState(error.toString()));
    }
  }

  List<Users> users=[];
  Future<List<Users>> getAllUsers(AccountType accountType) async {
    emit(GetAllUsersLoadingState());
     late final List<Users> result;
    try {
      if(accountType==AccountType.dealer){
       result = await getAllDealersUseCase.call();}
      else if(accountType==AccountType.customer){
        result = await getAllCustomersUseCase.call();}
      else if(accountType==AccountType.delegate){
        result = await getAllDelegatesUseCase.call();}
      users = result;
      emit(GetAllUsersSuccessState(users));
      return users;
    } catch (error) {
      emit(GetAllUsersFailureState(error.toString()));

      return [];
    }
  }



}
