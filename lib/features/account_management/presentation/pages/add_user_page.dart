import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/core/widgets/title_widget.dart';
import 'package:eks/features/account_management/presentation/pages/dealer/add_dealer_page.dart';
import 'package:eks/features/account_management/presentation/pages/delegate/add_delegate_page.dart';
import 'package:eks/core/widgets/border_widget.dart';
import 'package:eks/features/account_management/presentation/pages/customer/add_customer_page.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

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
                SizedBox(height: screenHeight * 0.03),
                Flexible(
                  child: Column(
                    children: [
                      buildIconButton(context, Icons.person_2 , S.of(context).addDelegate, AddDelegatePage(),screenWidth,screenHeight),
                      SizedBox(height: screenHeight * 0.05),
                      buildIconButton(context, Icons.sell, S.of(context).addDealer, AddDealerPage(),screenWidth,screenHeight),
                      SizedBox(height: screenHeight * 0.05),
                      buildIconButton(context, Icons.shop, S.of(context).addCustomer, AddCustomerPage(),screenWidth,screenHeight),
                      SizedBox(height: screenHeight * 0.09),
                      TitleWidget(),
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
