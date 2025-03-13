import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/button_log_sig.dart';
import 'package:eks/core/widgets/form_widget.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/features/account_management/data/models/account_type.dart';
import 'package:eks/features/account_management/domain/entities/users_entity.dart';
import 'package:eks/features/account_management/presentation/cubit/account_cubit.dart';
import 'package:eks/features/account_management/presentation/pages/dealer/all_dealers_page.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateDealerPage extends StatelessWidget {
  final int id;
  final String oldUsername;
  final String oldAddress;
  final String oldPhone;
  final String oldAdministratorName;
  final String oldAdministratorPhone;
  UpdateDealerPage({super.key,required this.id, required this.oldUsername, required this.oldAddress, required this.oldPhone, required this.oldAdministratorName, required this.oldAdministratorPhone});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController administratorNameController = TextEditingController();
  final TextEditingController administratorPhoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AccountCubit,AccountState>(
      listener: (BuildContext context, AccountState state) {
        if(state is AddOrUpdateAccountSuccessState){
          showToast(text: S.of(context).editSuccessfully, state: ToastState.SUCSSES);

          navigateToWithPushWithReplace(context, const AllDealersPage());
        }
        if(state is AddOrUpdateAccountErrorState){
          showToast(text: S.of(context).editFailed, state: ToastState.ERROR);
        }
      },
      builder: (BuildContext context, AccountState state) {
        AccountCubit cubit=AccountCubit.get(context);
        return Scaffold(
          appBar: mainAppBar(context),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    LogoWidget(height: screenHeight * 0.2),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      S.of(context).editDealer,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    FormWidget(
                      initialText: oldUsername,
                      label: S.of(context).username,
                      controller: usernameController,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    FormWidget(
                      initialText: oldAddress,
                      label: S.of(context).address,
                      controller: addressController,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    FormWidget(
                      initialText: oldPhone,
                      label: S.of(context).phone,
                      controller: phoneController,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    FormWidget(
                      initialText: oldAdministratorName,
                      label: S.of(context).administratorName,
                      controller: administratorNameController,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    FormWidget(
                      initialText: oldAdministratorPhone,
                      label: S.of(context).administratorPhone,
                      controller: administratorPhoneController,
                    ),
                    SizedBox(height: screenHeight * 0.05  ),
                    ButtonLogSig(
                      text: S.of(context).edit,
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.9,
                      onTap: () {
                        cubit.updateAccount(
                            Users(
                              id: id,
                              username: usernameController.text,
                              address:addressController.text,
                              phone: phoneController.text,
                              administratorName: administratorNameController.text,
                              administratorPhone: administratorPhoneController.text,
                            ),AccountType.dealer
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
    );
  }
}
