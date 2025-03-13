import 'package:eks/core/components/components.dart';
import 'package:eks/core/settigns/language/page/language_page.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/core/widgets/title_widget.dart';
import 'package:eks/features/account_management/presentation/pages/add_user_page.dart';
import 'package:eks/core/widgets/border_widget.dart';
import 'package:eks/features/inventory_management/presentation/pages/store_home_page.dart';
import 'package:eks/features/invoice_management/presentation/pages/invoice_home_page.dart';
import 'package:eks/features/product_management/presentation/pages/product/add_product_page.dart';
import 'package:eks/features/invoice_management/presentation/pages/add_invoice_page.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';

class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: BorderWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LogoWidget(
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.6,
                ),
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
                        buildIconButton(context, Icons.menu_rounded, S.of(context).imports, AddProductPage(), screenWidth, screenHeight),
                        buildIconButton(context, Icons.shuffle, S.of(context).exports, const AddInvoicePage(), screenWidth, screenHeight),
                        buildIconButton(context, Icons.person, S.of(context).addUser, const AddUserPage(), screenWidth, screenHeight),
                        buildIconButton(context, Icons.folder, S.of(context).reports, const InvoiceHomePage(), screenWidth, screenHeight),
                        buildIconButton(context, Icons.bar_chart, S.of(context).store, const StoreHomePage(), screenWidth, screenHeight),
                        buildIconButton(context, Icons.settings, S.of(context).settings, LanguageSwitcherPage(), screenWidth, screenHeight),
                      ],
                    );
                  },
                ),
                const TitleWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
