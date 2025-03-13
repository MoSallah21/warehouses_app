import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/button_log_sig.dart';
import 'package:eks/core/widgets/form_widget.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/features/product_management/domain/entities/unit_entity.dart';
import 'package:eks/features/product_management/presentation/cubit/product_cubit.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUnitPagePage extends StatelessWidget {
  AddUnitPagePage({super.key});

  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<ProductCubit, ProductState>(
      listener: (BuildContext context, ProductState state) {
        if (state is AddOrUpdateProductOrUnitSuccessState) {
          nameController.clear();
          showToast(text: S.of(context).addSuccessfully, state: ToastState.SUCSSES);
        } else if (state is AddOrUpdateProductOrUnitErrorState) {
          showToast(text: S.of(context).addFailed, state: ToastState.ERROR);
        } else if (state is AddOrUpdateProductOrUnitFailureState) {
          showToast(text: S.of(context).addFailed, state: ToastState.ERROR);
          debugPrint(state.error);
        }
      },
      builder: (BuildContext context, ProductState state) {
        ProductCubit cubit = ProductCubit.get(context);
        return Scaffold(
          appBar: mainAppBar(context),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    LogoWidget(height: screenHeight * 0.2),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      S.of(context).enterNewUnit,
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    FormWidget(
                      label: S.of(context).name,
                      controller: nameController,
                    ),
                    SizedBox(height: screenHeight * 0.08),
                    ButtonLogSig(
                      text: S.of(context).addNewProduct,
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.9,
                      onTap: () {
                        cubit.addUnit(
                          Unit(
                            type: nameController.text,
                          ),
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
