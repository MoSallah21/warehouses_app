import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_items_entity.dart';
import 'package:eks/features/invoice_management/presentation/cubit/invoice_cubit.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eks/injection_container.dart' as di;


class DetailInvoicePage extends StatelessWidget {
  final int id;
  final String clientName;
  final String invoiceNumber;
  final double totalPrice;
  final String invoiceDate;


  DetailInvoicePage({super.key,required this.id, required this.clientName, required this.invoiceNumber,required this.totalPrice,required this.invoiceDate});

  final formKey = GlobalKey<FormState>();
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
      )..getInvoice(id),
      child: Scaffold(
        appBar: mainAppBar(context),
        body: BlocConsumer<InvoiceCubit,InvoiceState>(
          listener: (BuildContext context, InvoiceState state) {  },
          builder: (BuildContext context, InvoiceState state) {
            InvoiceCubit cubit=InvoiceCubit.get(context);
            if (state is GetInvoiceLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetInvoiceFailureState) {
              print('Error: ${state.error}');
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is GetInvoiceSuccessState&&state.invoiceItems.isEmpty) {
              return const Center(child: Text('No data available',style: TextStyle(fontSize: 24),));
            }
            else {
              final List<InvoiceItems> invoiceItems = cubit.invoiceItems;
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      LogoWidget(height: screenHeight * 0.2),
                      SizedBox(height: screenHeight * 0.04),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text('${S.of(context).productName} :    $clientName',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Text('${S.of(context).code}:   $invoiceNumber',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.033,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Text('${S.of(context).totalPrice} :  $totalPrice',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.033,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text('${S.of(context).invoiceDate} :                $invoiceDate',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                  )),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: invoiceItems.length,
                        itemBuilder: (context, index) {
                          final InvoiceItems items = invoiceItems[index];
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
                                    Text('${S.of(context).name} :  ${items.productName}'),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text('   ${S.of(context).quantity} :  ${items.quantity}'),
                                        ),
                                        const SizedBox(width: 2.5),
                                        myDivider(context),
                                        Expanded(
                                          child:
                                          Text('      ${S.of(context).price} : ${items.price}')
                                        ),
                                        const SizedBox(width: 2.5),
                                        myDivider(context),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            alignment: Alignment.center,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                Text(
                                                  S
                                                      .of(context)
                                                      .totalPrice,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  "\t\t${(double.tryParse(
                                                      items.quantity.toString()) ?? 0) *
                                                      (double.tryParse(
                                                          items.price.toString()) ?? 0)}",
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
              );
            }},

        ),
      ),
    );
  }
}