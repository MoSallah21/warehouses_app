import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/button_log_sig.dart';
import 'package:eks/core/widgets/form_widget.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/features/product_management/domain/entities/unit_entity.dart';
import 'package:eks/features/product_management/presentation/cubit/product_cubit.dart';
import 'package:eks/features/product_management/presentation/pages/unit/all_units_page.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eks/injection_container.dart' as di;


class UpdateUnitPage extends StatelessWidget {
  final int id;
  final String oldUnit;



  UpdateUnitPage({super.key, required this.id, required this.oldUnit});

  final TextEditingController unitController = TextEditingController();
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
              navigateToWithPushWithReplace(context, AllUnitsPage());
            }
            if(state is AddOrUpdateProductOrUnitErrorState){
              showToast(text: S.of(context).editFailed, state: ToastState.ERROR);
            }
          },
          builder: (BuildContext context, ProductState state) {
            ProductCubit cubit=ProductCubit.get(context);

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
                        SizedBox(height: screenHeight * 0.03),
                        Row(
                          children: [
                              Expanded(
                                flex: 2,
                                child: FormWidget(
                                  initialText: oldUnit,
                                  label: S.of(context).unit,
                                  controller: unitController,
                                ),
                              ),
                          ],
                        ),SizedBox(height: screenHeight * 0.03),
                        SizedBox(height: screenHeight * 0.08),
                        ButtonLogSig(
                          text: S.of(context).edit,
                          height: screenHeight * 0.07,
                          width: screenWidth * 0.9,
                          onTap: () {
                            cubit.updateUnit(
                              Unit(id: id,type: unitController.text)
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