import 'package:eks/core/components/components.dart';
import 'package:eks/core/theme/app_pallete.dart';
import 'package:eks/core/utl/alert_message.dart';
import 'package:eks/core/widgets/form_widget.dart';
import 'package:eks/features/product_management/domain/entities/product_entity.dart';
import 'package:eks/features/product_management/presentation/cubit/product_cubit.dart';
import 'package:eks/features/product_management/presentation/pages/product/detail_product_page.dart';
import 'package:eks/features/product_management/presentation/pages/product/update_product_page.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eks/injection_container.dart' as di;

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});
  @override
  AllProductsPageState createState() => AllProductsPageState();
}

class AllProductsPageState extends State<AllProductsPage> {
  final TextEditingController nameController = TextEditingController();
  List<Product> filteredProducts = [];

  @override
  Widget build(BuildContext context) {
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
      )..getAllProducts(),
      child: Scaffold(
        appBar: mainAppBar(context),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            ProductCubit cubit = ProductCubit.get(context);
            if (state is DeleteProductOrUnitSuccessState) {
              showToast(text: S.of(context).deleteSuccessfully, state: ToastState.SUCSSES);
              Navigator.of(context).pop();
              cubit.getAllProducts();
            }
            else if (state is DeleteProductOrUnitErrorState) {
              showToast(text: S.of(context).deleteFailed, state: ToastState.ERROR);
              Navigator.of(context).pop();
            }
            else if (state is DeleteProductOrUnitFailureState) {
              showToast(text: S.of(context).deleteFailed, state: ToastState.ERROR);
              Navigator.of(context).pop();
            }
            if (state is GetAllProductsOrUnitsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetAllProductsOrUnitsFailureState) {
              debugPrint('Error: ${state.error}');
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is GetAllProductsOrUnitsSuccessState && state.products!.isEmpty) {
              return const Center(child: Text('No data available', style: TextStyle(fontSize: 24)));
            } else {
              final List<Product> products = cubit.products;
              if (filteredProducts.isEmpty) {
                filteredProducts = products;
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
                        label: S.of(context).productName,
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {
                            filteredProducts = products.where((product) {
                              return product.name.toLowerCase().startsWith(value.toLowerCase());
                            }).toList();
                          });
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(S.of(context).allProducts, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: screenHeight * 0.01),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final Product product = filteredProducts[index];
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  navigateTo(context, DetailProductPage(
                                      oldName: product.name,
                                      oldCode: product.code,
                                      oldUnit: product.unit,
                                      oldPrice: product.price,
                                      oldQuantity: product.quantity));
                                },
                                child: Card(
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
                                              Text(product.name,
                                                  style: TextStyle(fontSize: screenWidth * 0.033)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 2.5),
                                      myDivider(context),
                                      const SizedBox(width: 2.5),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Text(product.quantity.toString(),
                                                  style: TextStyle(fontSize: screenWidth * 0.033)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 2.5),
                                      myDivider(context),
                                      const SizedBox(width: 2.5),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Text(product.price.toString(),
                                                  style: TextStyle(fontSize: screenWidth * 0.033)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit_outlined, color: Pallat.iconsAndButtonColor, size: screenWidth * 0.07),
                                    onPressed: () {
                                      navigateTo(context, UpdateProductPage(
                                        id: product.id!,
                                        oldName: product.name,
                                        oldUnit: product.unit!,
                                        oldCode: product.code,
                                        oldPrice: product.price,
                                        oldQuantity: product.quantity,
                                      ));
                                    },
                                  ),
                                  const SizedBox(width: 160),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline_outlined, color: Colors.red, size: screenWidth * 0.07),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertMessage().alertDia(S.of(context).product, context, () {
                                            cubit.deleteProduct(product.id!);
                                            return null;
                                          });
                                        },
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
