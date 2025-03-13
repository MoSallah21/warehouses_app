import 'package:eks/core/components/components.dart';
import 'package:eks/core/theme/app_pallete.dart';
import 'package:eks/core/utl/alert_message.dart';
import 'package:eks/core/widgets/form_widget.dart';
import 'package:eks/features/product_management/domain/entities/unit_entity.dart';
import 'package:eks/features/product_management/presentation/cubit/product_cubit.dart';
import 'package:eks/features/product_management/presentation/pages/unit/update_unit_page.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eks/injection_container.dart' as di;

class AllUnitsPage extends StatefulWidget {
  const AllUnitsPage({super.key});

  @override
  State<AllUnitsPage> createState() => _AllUnitsPageState();
}

class _AllUnitsPageState extends State<AllUnitsPage> {
  final TextEditingController nameController=TextEditingController();
  List<Unit> filteredUnits = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(
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
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            ProductCubit cubit=ProductCubit.get(context);
            if(state is DeleteProductOrUnitSuccessState){
              showToast(text: S.of(context).deleteSuccessfully, state: ToastState.SUCSSES);
              Navigator.of(context).pop();
              cubit.getAllUnits();
            }
          else  if(state is DeleteProductOrUnitErrorState){
              showToast(text: S.of(context).deleteFailed, state: ToastState.ERROR);
              debugPrint(state.errors.toString());
              Navigator.of(context).pop();
            }
           else if(state is DeleteProductOrUnitFailureState){
              showToast(text: S.of(context).deleteFailed, state: ToastState.ERROR);
              debugPrint(state.error.toString());
              Navigator.of(context).pop();
            }
            if (state is GetAllProductsOrUnitsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetAllProductsOrUnitsFailureState) {
              debugPrint('Error: ${state.error}');
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is GetAllProductsOrUnitsSuccessState&&state.units!.isEmpty) {
              return const Center(child: Text('No data available',style: TextStyle(fontSize: 24),));
            } else {
              final List<Unit> units = cubit.units;
              if (filteredUnits.isEmpty) {
                filteredUnits = units;
              }
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      FormWidget(
                        onChanged: (value) {
                          setState(() {
                            filteredUnits = units.where((unit) {
                              return unit.type!.toLowerCase().startsWith(value.toLowerCase());
                            }).toList();
                          });
                        },

                        label: S.of(context).productName,
                        controller: nameController,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(S.of(context).allUnits, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: screenHeight * 0.01),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredUnits.length,
                        itemBuilder: (context, index) {
                          final Unit unit = filteredUnits[index];
                          return Column(
                            children: [
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Text(unit.type!,
                                                style: TextStyle(fontSize: screenWidth * 0.035,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit_outlined, color: Pallat.iconsAndButtonColor,size: screenWidth * 0.07,),
                                    onPressed: () {
                                      navigateTo(context, UpdateUnitPage(
                                        id: unit.id!, oldUnit: unit.type!,
                                      ));
                                    },
                                  ),
                                  const SizedBox(width: 160,),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline_outlined, color: Colors.red,size: screenWidth * 0.07,),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertMessage().alertDia(S.of(context).unit,context,
                                                  (){
                                                cubit.deleteUnit(unit.id!,);
                                                return null;});},
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
