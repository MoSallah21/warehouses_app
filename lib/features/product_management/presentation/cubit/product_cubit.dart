import 'package:eks/features/product_management/domain/entities/product_entity.dart';
import 'package:eks/features/product_management/domain/entities/unit_entity.dart';
import 'package:eks/features/product_management/domain/usecases/add/add_product.dart';
import 'package:eks/features/product_management/domain/usecases/add/add_unit.dart';
import 'package:eks/features/product_management/domain/usecases/delete/delete_product.dart';
import 'package:eks/features/product_management/domain/usecases/delete/delete_unit.dart';
import 'package:eks/features/product_management/domain/usecases/get/get_all_units.dart';
import 'package:eks/features/product_management/domain/usecases/update/update_product.dart';
import 'package:eks/features/product_management/domain/usecases/update/update_unit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get/get_all_products.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final AddProductUseCase addProductUseCase;
  final GetAllProductsUseCase getAllProductsUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final AddUnitUseCase addUnitUseCase;
  final GetAllUnitsUseCase getAllUnitsUseCase;
  final UpdateUnitUseCase updateUnitUseCase;
  final DeleteUnitUseCase deleteUnitUseCase;


  ProductCubit({required this.addProductUseCase,required this.updateProductUseCase,required this.deleteProductUseCase,required this.getAllProductsUseCase,required this.addUnitUseCase,required this.getAllUnitsUseCase,required this.updateUnitUseCase,required this.deleteUnitUseCase, }) : super(ProductInitState());


  static ProductCubit get(context) => BlocProvider.of(context);


  Future<void> addProduct(Product product) async {
    emit(AddOrUpdateProductOrUnitLoadingState());
    try {
      final result = await addProductUseCase.call(product);

      if (result.isEmpty) {
        emit(AddOrUpdateProductOrUnitSuccessState());
      } else {
        emit(AddOrUpdateProductOrUnitErrorState(result));
      }
    } catch (error) {
      emit(AddOrUpdateProductOrUnitFailureState(error.toString()));
    }
  }

  Future<void> updateProduct(Product product) async {
    emit(AddOrUpdateProductOrUnitLoadingState());

    try {
      final result = await updateProductUseCase.call(product);
      if (result.isEmpty) {
        emit(AddOrUpdateProductOrUnitSuccessState());
      } else {
        emit(AddOrUpdateProductOrUnitErrorState(result));
      }
    } catch (error) {
      emit(AddOrUpdateProductOrUnitFailureState(error.toString()));
    }
  }

  Future<void> deleteProduct(int id) async {
    emit(DeleteProductOrUnitLoadingState());

    try {
      final result = await deleteProductUseCase.call(id);

      if (result.isEmpty) {
        emit(DeleteProductOrUnitSuccessState());
      } else {
        emit(DeleteProductOrUnitErrorState(result));
      }
    } catch (error) {
      emit(DeleteProductOrUnitFailureState(error.toString()));
    }
  }

  List<Product> products = [];
  Future<List<Product>> getAllProducts() async {
    emit(GetAllProductsOrUnitsLoadingState());
    try {
      final result = await getAllProductsUseCase.call();
      products = result;
      emit(GetAllProductsOrUnitsSuccessState(products: products));
      return products;
    } catch (error) {
      emit(GetAllProductsOrUnitsFailureState(error.toString()));
      return [];
    }
  }

  Future<void> addUnit(Unit unit) async {
    emit(AddOrUpdateProductOrUnitLoadingState());
    try {
      final result = await addUnitUseCase.call(unit);

      if (result.isEmpty) {
        emit(AddOrUpdateProductOrUnitSuccessState());
      } else {
        emit(AddOrUpdateProductOrUnitErrorState(result));
      }
    } catch (error) {
      emit(AddOrUpdateProductOrUnitFailureState(error.toString()));
    }
  }

  Future<void> updateUnit(Unit unit) async {
    emit(AddOrUpdateProductOrUnitLoadingState());

    try {
      final result = await updateUnitUseCase.call(unit);
      if (result.isEmpty) {
        emit(AddOrUpdateProductOrUnitSuccessState());
      } else {
        emit(AddOrUpdateProductOrUnitErrorState(result));
      }
    } catch (error) {
      emit(AddOrUpdateProductOrUnitFailureState(error.toString()));
    }
  }

  Future<void> deleteUnit(int id) async {
    emit(DeleteProductOrUnitLoadingState());

    try {
      final result = await deleteUnitUseCase.call(id);

      if (result.isEmpty) {
        emit(DeleteProductOrUnitSuccessState());
      } else {
        emit(DeleteProductOrUnitErrorState(result));
      }
    } catch (error) {
      emit(DeleteProductOrUnitFailureState(error.toString()));
    }
  }

  List<Unit> units = [];
  Future<List<Unit>> getAllUnits() async {
    emit(GetAllProductsOrUnitsLoadingState());
    try {
      final result = await getAllUnitsUseCase.call();
      units = result;
      emit(GetAllProductsOrUnitsSuccessState(units: units));
      return units;
    } catch (error) {
      emit(GetAllProductsOrUnitsFailureState(error.toString()));
      return [];
    }
  }






}
