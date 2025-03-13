part of 'account_cubit.dart';

abstract class AccountState {}

class AccountInitState extends AccountState {}

class AddOrUpdateAccountLoadingState extends AccountState {}

class AddOrUpdateAccountSuccessState extends AccountState {}

class AddOrUpdateAccountFailureState extends AccountState {
  final String error;
  AddOrUpdateAccountFailureState(this.error);
}

class AddOrUpdateAccountErrorState extends AccountState {
  final List<dynamic> errors;
  AddOrUpdateAccountErrorState(this.errors);
}

class DeleteAccountLoadingState extends AccountState {}

class DeleteAccountSuccessState extends AccountState {}

class DeleteAccountFailureState extends AccountState {
  final String error;
  DeleteAccountFailureState(this.error);
}

class DeleteAccountErrorState extends AccountState {
  final List<dynamic> errors;
  DeleteAccountErrorState(this.errors);
}

class GetAllUsersLoadingState extends AccountState {}

class GetAllUsersSuccessState extends AccountState {
  final List<Users> users;
  GetAllUsersSuccessState(this.users);
}

class GetAllUsersFailureState extends AccountState {
  final String error;
  GetAllUsersFailureState(this.error);
}
