import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/core/widgets/border_widget.dart';
import 'package:eks/features/account_management/presentation/pages/customer/all_customers_page.dart';
import 'package:eks/features/account_management/presentation/pages/dealer/all_dealers_page.dart';
import 'package:eks/features/account_management/presentation/pages/delegate/all_delegates_page.dart';
import 'package:eks/features/product_management/presentation/pages/product/all_products_page.dart';
import 'package:eks/features/product_management/presentation/pages/unit/all_units_page.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';

class StoreHomePage extends StatelessWidget {
  const StoreHomePage({super.key});

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
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = screenWidth > 600 ? 3 : 2;
                    return GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: screenWidth * 0.03,
                      mainAxisSpacing: screenHeight * 0.02,
                      children: [
                        buildIconButton(context, Icons.production_quantity_limits, S.of(context).allProducts, AllProductsPage(), screenWidth, screenHeight),
                        buildIconButton(context, Icons.handshake, S.of(context).allDelegates, AllDelegatesPage(), screenWidth, screenHeight),
                        buildIconButton(context, Icons.person, S.of(context).allDealers, AllDealersPage(), screenWidth, screenHeight),
                        buildIconButton(context, Icons.shop_outlined, S.of(context).allCustomers, AllCustomersPage(), screenWidth, screenHeight),
                        buildIconButton(context, Icons.ac_unit, S.of(context).allUnits, AllUnitsPage(), screenWidth, screenHeight),

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
  }

}
