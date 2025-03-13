import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/core/widgets/title_widget.dart';
import 'package:eks/core/widgets/border_widget.dart';
import 'package:eks/features/invoice_management/presentation/pages/all_invoices_page.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';

class InvoiceHomePage extends StatelessWidget {
  const InvoiceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: BorderWidget(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),

                LogoWidget(height: screenHeight * 0.2, width: screenWidth * 0.6),
                SizedBox(height: screenHeight * 0.1),
                Flexible(
                  child: Column(
                    children: [
                      buildIconButton(context, Icons.trolley , S.of(context).buy, const AllInvoicesPage(invoiceType: 'buy',),screenWidth,screenHeight),
                      SizedBox(height: screenHeight * 0.15),
                      buildIconButton(context, Icons.sell_outlined, S.of(context).sell, const AllInvoicesPage(invoiceType: 'sell',),screenWidth,screenHeight),
                      SizedBox(height: screenHeight * 0.1),
                      const TitleWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
