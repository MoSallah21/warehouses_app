import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/form_widget.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_entity.dart';
import 'package:eks/features/invoice_management/presentation/cubit/invoice_cubit.dart';
import 'package:eks/features/invoice_management/presentation/pages/detail_invoice_page.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eks/injection_container.dart' as di;

class AllInvoicesPage extends StatefulWidget {
  final String invoiceType;
  const AllInvoicesPage({super.key,required this.invoiceType});

  @override
  State<AllInvoicesPage> createState() => _AllInvoicesPageState();

}

class _AllInvoicesPageState extends State<AllInvoicesPage> {
  final TextEditingController nameController = TextEditingController();
  List<Invoice> filteredInvoice = [];

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
      )..getAllInvoices(widget.invoiceType),
      child: Scaffold(
        appBar: mainAppBar(context),
        body: BlocBuilder<InvoiceCubit, InvoiceState>(
          builder: (context, state) {
            InvoiceCubit cubit=InvoiceCubit.get(context);
            if (state is GetAllInvoicesLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetAllInvoicesFailureState) {
              print('Error: ${state.error}');
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is GetAllInvoicesSuccessState&&state.invoices.isEmpty) {
              return Center(child: Text('No data available',style: TextStyle(fontSize: 24),));
            } else {
              final List<Invoice> invoices = cubit.invoices;
              if (filteredInvoice.isEmpty) {
                filteredInvoice = invoices;
              }
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      FormWidget(
                        label: S.of(context).name,
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {
                            filteredInvoice = invoices.where((invoice) {
                              return invoice.clientName.toLowerCase().startsWith(value.toLowerCase());
                            }).toList();
                          });
                        },
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(S.of(context).allInvoices, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: screenHeight * 0.01),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredInvoice.length,
                        itemBuilder: (context, index) {
                          final Invoice invoice = filteredInvoice[index];
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  navigateTo(context, DetailInvoicePage(
                                      id: invoice.id!,
                                      clientName: invoice.clientName,
                                      invoiceNumber: invoice.number,
                                      totalPrice: invoice.totalPrice!,
                                      invoiceDate: invoice.date));
                                },
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
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
                                            Text('${S.of(context).name} :    '+invoice.clientName,
                                                style: TextStyle(fontSize: screenWidth * 0.033,
                                                )),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Column(
                                                children: [
                                                  Text('${S.of(context).invoiceNumber}:   '+invoice.number,
                                                    style: TextStyle(fontSize: screenWidth * 0.033,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [

                                                  Text('${S.of(context).totalPrice}',
                                                    style: TextStyle(fontSize: screenWidth * 0.033,
                                                    ),
                                                  ),
                                                  Text('${invoice.totalPrice}',
                                                    style: TextStyle(fontSize: screenWidth * 0.033,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
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
