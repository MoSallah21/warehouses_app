import 'dart:core';
import 'package:eks/core/components/components.dart';
import 'package:eks/core/theme/app_pallete.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/features/account_management/data/models/account_type.dart';
import 'package:eks/features/invoice_management/data/models/invoice_items_model.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_entity.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_items_entity.dart';
import 'package:eks/features/invoice_management/presentation/cubit/invoice_cubit.dart';
import 'package:eks/features/product_management/presentation/widgets/date_picker.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_choices/search_choices.dart';
import 'package:eks/injection_container.dart' as di;
class AddInvoicePage extends StatefulWidget {
  final String? dealer;
  const AddInvoicePage({super.key, this.dealer});

  @override
  State<AddInvoicePage> createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController invoiceNumberController = TextEditingController();
  final TextEditingController numberOfProductController = TextEditingController();
  List<TextEditingController> quantityControllers = [];
  List<TextEditingController> priceControllers = [];
  List<InvoiceItems> productItems = [];
  List<String>selectedProduct=[];
  int? selectedValue=0;
  double total=0;
  String? selectedDealerOrCustomer;
  List<String>?dealers;
  List<String>?customers;
  List<String>?productName;
  List<double>?productPrice;
  List<double>?productQuantity;
  Invoice createInvoice() {
    List<InvoiceItemsModel> invoiceItems = _prepareInvoiceItems();
    String invoiceNumber = invoiceNumberController.text;
    String invoiceDate = _dateController.text;
    String invoiceType = selectedValue == 1 ? 'buy' : 'sell';
    String? clientName = selectedDealerOrCustomer;
    Invoice invoice = Invoice(
      number: invoiceNumber,
      date: invoiceDate,
      invoiceType: invoiceType,
      clientName: clientName!,
      items: invoiceItems,
      totalPrice: total,
    );
    print(invoice.toString());
    return invoice;
  }
  void calculateTotal() {
    double newTotal = 0;
    for (int i = 0; i < quantityControllers.length; i++) {
      double quantity = double.tryParse(quantityControllers[i].text) ?? 0;
      double price = double.tryParse(priceControllers[i].text) ?? 0;
      newTotal += quantity * price;
    }
    setState(() {
      total = newTotal;
    });
  }
  List<InvoiceItemsModel> _prepareInvoiceItems() {
    List<InvoiceItemsModel> invoiceItems = [];
    for (int i = 0; i < quantityControllers.length; i++) {
      String productName = selectedProduct[i];
      double quantity = double.tryParse(quantityControllers[i].text) ?? 0;
      double price = double.tryParse(priceControllers[i].text) ?? 0;
      invoiceItems.add(InvoiceItemsModel(
        productName: productName,
        quantity: quantity,
        price: price,
      ));
    }
    return invoiceItems;
  }
  final formKey = GlobalKey<FormState>();
  void updateProductItems() {
    setState(() {
      productItems.clear();
      int itemCount = int.tryParse(numberOfProductController.text) ?? 0;
      for (int i = 0; i < itemCount; i++) {
        double quantity = double.tryParse(quantityControllers[i].text) ?? 0;
        double price = double.tryParse(priceControllers[i].text) ?? 0;
        productItems.add(InvoiceItems(
          productName: '',
          quantity: quantity,
          price: price,
        ));
      }
    });
  }
  @override
  void dispose() {
    _dateController.dispose();
    numberOfProductController.dispose();
    for (var controller in quantityControllers) {
      controller.dispose();
    }
    for (var controller in priceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => InvoiceCubit(
             addInvoiceUseCase: di.sl(),
            updateInvoiceUseCase: di.sl(),
            deleteInvoiceUseCase: di.sl(),
            getAllInvoicesUseCase: di.sl(),
            getAllDealersUseCase: di.sl(),
            getAllCustomersUseCase: di.sl(),
            getAllProductsUseCase: di.sl(),
            getInvoiceUseCase: di.sl(),
        )..getAllProducts()..getAllDealersOrCustomers(AccountType.dealer)..getAllDealersOrCustomers(AccountType.customer),
      
      child: BlocConsumer<InvoiceCubit,InvoiceState>(
        listener: (BuildContext context, state) {
          if(state is AddOrUpdateInvoiceErrorState){
            print(state.errors.toString());
          }
         else if(state is AddOrUpdateInvoiceFailureState){
            print(state.error.toString());
          }
          else if (state is AddOrUpdateInvoiceSuccessState) {
            _dateController.clear();
            invoiceNumberController.clear();
            numberOfProductController.clear();
            for (var controller in quantityControllers) {
              controller.clear();
            }
            for (var controller in priceControllers) {
              controller.clear();
            }
            setState(() {
              selectedProduct.clear();
              quantityControllers.clear();
              priceControllers.clear();
              selectedDealerOrCustomer = null;
              selectedValue = 0;
              total = 0;
            });
          }
        },
        builder: (BuildContext context, Object? state) {
          InvoiceCubit cubit=InvoiceCubit.get(context);
          productName = cubit.products.map((productName) => productName.name).toSet().toList();
          productQuantity = cubit.products.map((productQuantity) => productQuantity.quantity).toSet().toList();
          productPrice = cubit.products.map((productPrice) => productPrice.price).toSet().toList();
          return Scaffold(
            appBar: mainAppBar(context),
            bottomNavigationBar: Container(
              height: 150,
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).totalPrice+' :',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${total}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 40),
                      backgroundColor: Pallat.iconsAndButtonColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      cubit.addInvoice(createInvoice());
                    },
                    child: Text(
                      S.of(context).enter,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      const Center(
                        child: LogoWidget(height: 100),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20,),
                          Expanded(
                            child: RadioListTile<int>(
                              title: Text(S.of(context).buy),
                              value: 1,
                              fillColor: WidgetStateProperty.all(const Color(0xFFFFB600)),
                              groupValue: selectedValue,
                              onChanged: (int? value) {
                                dealers = cubit.dealers.map((user) => user.username!).toSet().toList();

                                setState(() {
                                  selectedValue = value;
                                  dealers = cubit.dealers.map((user) => user.username!).toSet().toList();
                                  selectedDealerOrCustomer = null;
                                });
                                setState(() {

                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<int>(
                              title: Text(S.of(context).sell),
                              value: 2,
                              fillColor: WidgetStateProperty.all(const Color(0xFFFFB600)),
                              groupValue: selectedValue,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedValue = value;
                                  customers = cubit.customers.map((user) => user.username!).toSet().toList();
                                  selectedDealerOrCustomer = null;
                                });
                                setState(() {

                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (selectedValue == 1)
                        DropdownButtonFormField(
                          value: selectedDealerOrCustomer,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: Text(S.of(context).dealerName),
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(Icons.person_2),
                          ),
                          items: dealers?.map((String user) {
                            return DropdownMenuItem<String>(
                              value: user,
                              child: Text(user),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDealerOrCustomer = value;
                            });
                          },
                        ),
                      if (selectedValue == 2)
                        DropdownButtonFormField(
                          value: selectedDealerOrCustomer,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: Text(S.of(context).customerName),
                            labelStyle: const TextStyle(color: Colors.black),
                            prefixIcon: const Icon(Icons.person_2),
                          ),
                          items: customers?.map((String user) {
                            return DropdownMenuItem<String>(
                              value: user,
                              child: Text(user),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDealerOrCustomer = value;
                            });
                          },
                        ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: DatePickerWidget(controller: _dateController),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: invoiceNumberController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.edit),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText:S.of(context).invoiceNumber,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: numberOfProductController,
                        onChanged: (String? x) {
                          int itemCount = int.tryParse(numberOfProductController.text) ?? 0;
                          itemCount = itemCount < 20 ? itemCount : 20;

                          if (quantityControllers.length < itemCount) {
                            for (int i = quantityControllers.length; i < itemCount; i++) {
                              quantityControllers.add(TextEditingController());
                              priceControllers.add(TextEditingController());
                            }
                          } else if (quantityControllers.length > itemCount) {
                            for (int i = quantityControllers.length - 1; i >= itemCount; i--) {
                              quantityControllers[i].dispose();
                              priceControllers[i].dispose();
                              quantityControllers.removeAt(i);
                              priceControllers.removeAt(i);
                            }
                          }
                          updateProductItems();
                        },
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.menu),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.amber),
                          ),
                          hintText: S().count,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: quantityControllers.length,
                        itemBuilder: (context, index) {
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
                                child: Column(
                                  children: [
                                    SearchChoices.single(
                                      items: productName?.map((item) {
                                        return DropdownMenuItem(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 50),
                                            child: Center(child: Text(item)),
                                          ),
                                          value: item,
                                        );
                                      }).toList(),
                                      underline: Container(
                                        height: 1,
                                        color: const Color(0xFF707070),
                                      ),
                                      value: selectedProduct.length > index ? selectedProduct[index] : null,
                                      hint: Center(child: Text('${S.of(context).productName}')),
                                      displayClearIcon: false,
                                      searchHint: S.of(context).selectOne,
                                      onChanged: (value) {
                                        setState(() {
                                          if (selectedProduct.length > index) {
                                            selectedProduct[index] = value!;
                                          } else {
                                            selectedProduct.add(value!);
                                          }
                                        });
                                      },
                                      isExpanded: true,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                            decoration: InputDecoration(
                                              hintText: S.of(context).quantity,
                                              hintStyle: const TextStyle(fontSize: 14),
                                              border: const OutlineInputBorder(),
                                              focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.transparent),
                                              ),
                                              enabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.transparent),
                                              ),
                                            ),
                                            controller: quantityControllers[index],
                                            onChanged: (String? x) {
                                              updateProductItems();
                                              calculateTotal();
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 2.5),
                                        myDivider(context),
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              focusColor: Colors.transparent,
                                              hintText: S.of(context).price,
                                              border: const OutlineInputBorder(),
                                              focusedBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.transparent),
                                              ),
                                              enabledBorder: const OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.transparent),
                                              ),
                                              hintStyle: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            controller: priceControllers[index],
                                            onChanged: (String? x) {
                                              updateProductItems();
                                              calculateTotal();

                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 2.5),
                                        myDivider(context),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            alignment: Alignment.center,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  S.of(context).totalPrice,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  "\t\t${(double.tryParse(quantityControllers[index].text) ?? 0) * (double.tryParse(priceControllers[index].text) ?? 0)}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),

                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

            ),
          );
        },


      ),
    );
  }
}
