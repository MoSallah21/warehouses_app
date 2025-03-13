import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/button_log_sig.dart';
import 'package:eks/core/widgets/form_widget.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/features/account_management/data/models/account_type.dart';
import 'package:eks/features/account_management/domain/entities/users_entity.dart';
import 'package:eks/features/account_management/presentation/cubit/account_cubit.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDelegatePage extends StatelessWidget {
  AddDelegatePage({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<AccountCubit,AccountState>(
      listener: (BuildContext context, AccountState state) {
        if(state is AddOrUpdateAccountSuccessState){
          usernameController.clear();
          passwordController.clear();
          showToast(text: S.of(context).addSuccessfully, state: ToastState.SUCSSES);

        }
        if(state is AddOrUpdateAccountErrorState){
          showToast(text: S.of(context).addFailed, state: ToastState.ERROR);
          debugPrint(state.errors.toString());

        }
        if(state is AddOrUpdateAccountFailureState){
          showToast(text: S.of(context).editFailed, state: ToastState.ERROR);
          debugPrint(state.error);
        }

      },
      builder: (BuildContext context, AccountState state) {
        AccountCubit cubit=AccountCubit.get(context);
        return Scaffold(
          appBar: mainAppBar(context),
          body:
          state is! AddOrUpdateAccountLoadingState?
            SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    LogoWidget(height: screenHeight * 0.2),
                    SizedBox(height: screenHeight * 0.05),
                    Text(
                      S.of(context).enterNewDelegate,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    FormWidget(
                      label: S.of(context).username,
                      controller: usernameController,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    FormWidget(
                      label: S.of(context).password,
                      controller: passwordController,
                      textShow: true,
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    ButtonLogSig(
                      text: S.of(context).addDelegate,
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.9,
                      onTap: () {
                        cubit.addAccount(
                          Users(username:usernameController.text,password:passwordController.text),AccountType.delegate);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ):
          const Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }
}
