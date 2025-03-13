part of 'product_cubit.dart';
abstract class ProductState{}

class ProductInitState extends ProductState{}

class AddOrUpdateProductOrUnitLoadingState extends ProductState {}

class AddOrUpdateProductOrUnitSuccessState extends ProductState {}

class AddOrUpdateProductOrUnitFailureState extends ProductState {
  final String error;
  AddOrUpdateProductOrUnitFailureState(this.error);
}

class AddOrUpdateProductOrUnitErrorState extends ProductState {
  final List<dynamic> errors;
  AddOrUpdateProductOrUnitErrorState(this.errors);
}

class DeleteProductOrUnitLoadingState extends ProductState {}

class DeleteProductOrUnitSuccessState extends ProductState {}

class DeleteProductOrUnitFailureState extends ProductState {
  final String error;
  DeleteProductOrUnitFailureState(this.error);
}

class DeleteProductOrUnitErrorState extends ProductState {
  final List<dynamic> errors;
  DeleteProductOrUnitErrorState(this.errors);
}

class GetAllProductsOrUnitsLoadingState extends ProductState {}

class GetAllProductsOrUnitsSuccessState extends ProductState {
  final List<Product>? products;
  final List<Unit>?units;
  GetAllProductsOrUnitsSuccessState({this.products,this.units});
}

class GetAllProductsOrUnitsFailureState extends ProductState {
  final String error;
  GetAllProductsOrUnitsFailureState(this.error);
}
class ChangUnitState extends ProductState {
}



