import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/button_log_sig.dart';
import 'package:eks/core/widgets/form_widget.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/features/product_management/domain/entities/product_entity.dart';
import 'package:eks/features/product_management/domain/entities/unit_entity.dart';
import 'package:eks/features/product_management/presentation/cubit/product_cubit.dart';
import 'package:eks/features/product_management/presentation/pages/product/all_products_page.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eks/injection_container.dart' as di;


class UpdateProductPage extends StatelessWidget {
  final int id;
  final String oldName;
  final String oldCode;
  final String oldUnit;
  final double oldPrice;
  final double oldQuantity;


  UpdateProductPage({super.key, required this.id, required this.oldName, required this.oldCode,required this.oldUnit, required this.oldPrice, required this.oldQuantity});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedUnit;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => ProductCubit(
        addProductUseCase: di.sl(),
        updateProductUseCase: di.sl(),
        deleteProductUseCase: di.sl(),
        getAllProductsUseCase: di.sl(),
        addUnitUseCase: di.sl(),
        getAllUnitsUseCase: di.sl(),
        updateUnitUseCase: di.sl(),
        deleteUnitUseCase: di.sl(),
      )..getAllUnits(),
      child: Scaffold(
        appBar: mainAppBar(context),
        body:  BlocConsumer<ProductCubit,ProductState>(
          listener: (BuildContext context, ProductState state) {
            if(state is AddOrUpdateProductOrUnitSuccessState){
              showToast(text: S.of(context).editSuccessfully, state: ToastState.SUCSSES);
              navigateToWithPushWithReplace(context, AllProductsPage());
            }
            if(state is AddOrUpdateProductOrUnitErrorState){
              showToast(text: S.of(context).editFailed, state: ToastState.ERROR);
            }
          },
          builder: (BuildContext context, ProductState state) {
            ProductCubit cubit=ProductCubit.get(context);
            final List<String> types = cubit.units.map((unit) => unit.type!).toList();
            if(cubit.units.isNotEmpty){
              types.add(S.of(context).addUnit);
            }
             return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        LogoWidget(height: screenHeight * 0.2),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          S.of(context).editProduct,
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        FormWidget(
                          initialText: oldName,
                          label: S.of(context).name,
                          controller: nameController,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        FormWidget(
                          inputType:  TextInputType.streetAddress,
                          initialText: oldCode,
                          label: S.of(context).code,
                          controller: codeController,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: FormWidget(
                                initialText: oldQuantity.toString(),
                                inputType: TextInputType.numberWithOptions(decimal: true),
                                label: S.of(context).quantity,
                                controller: quantityController,
                              ),
                            ),
                            SizedBox(width: 10),
                            if(selectedUnit!=S.of(context).addUnit)
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    label: Text(S.of(context).unit),
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  value:oldUnit,
                                  items: types.map((String type) {
                                    return DropdownMenuItem<String>(
                                      value: type,
                                      child: Text(type),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value == S.of(context).addUnit) {
                                      selectedUnit = S.of(context).addUnit;
                                    } else {
                                      selectedUnit = value;
                                    }
                                    cubit.emit(ChangUnitState());
                                  },
                                ),
                              ),
                            if (selectedUnit == S.of(context).addUnit)
                              Expanded(
                                flex: 2,
                                child: FormWidget(
                                  label: S.of(context).unit,
                                  controller: unitController,
                                ),
                              ),
                          ],
                        ),SizedBox(height: screenHeight * 0.03),
                        FormWidget(
                          initialText: oldPrice.toString(),
                          label: S.of(context).price,
                          controller: priceController,
                        ),
                        SizedBox(height: screenHeight * 0.08),
                        ButtonLogSig(
                          text: S.of(context).edit,
                          height: screenHeight * 0.07,
                          width: screenWidth * 0.9,
                          onTap: () {
                            String quantityText = quantityController.text;
                            String priceText = priceController.text;
                            if (selectedUnit == S.of(context).addUnit && unitController.text.isNotEmpty) {
                              selectedUnit = unitController.text;
                              cubit.addUnit(Unit(type: unitController.text));
                            }
                            cubit.updateProduct(
                                Product(
                                    id: id,
                                    name: nameController.text,
                                    code: codeController.text,
                                    unit: selectedUnit,
                                    quantity: double.parse(quantityText),
                                    price: double.parse(priceText)
                                )
                            );


                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
          },

        ),
      ),
    );
  }
}