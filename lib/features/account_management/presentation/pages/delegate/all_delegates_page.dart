import 'package:eks/core/components/components.dart';
import 'package:eks/core/theme/app_pallete.dart';
import 'package:eks/core/utl/alert_message.dart';
import 'package:eks/core/widgets/form_widget.dart';
import 'package:eks/features/account_management/data/models/account_type.dart';
import 'package:eks/features/account_management/domain/entities/users_entity.dart';
import 'package:eks/features/account_management/presentation/cubit/account_cubit.dart';
import 'package:eks/features/account_management/presentation/pages/delegate/detail_delegate_page.dart';
import 'package:eks/features/account_management/presentation/pages/delegate/update_delegate_page.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eks/injection_container.dart' as di;

class AllDelegatesPage extends StatefulWidget {
  const AllDelegatesPage({super.key});

  @override
  State<AllDelegatesPage> createState() => _AllDelegatesPageState();
}

class _AllDelegatesPageState extends State<AllDelegatesPage> {
  final TextEditingController nameController=TextEditingController();
  List<Users> filteredUsers = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountCubit(
        addDealerUseCase: di.sl(),
        addCustomerUseCase: di.sl(),
        addDelegateUseCase: di.sl(),
        updateDealerUseCase: di.sl(),
        updateCustomerUseCase: di.sl(),
        updateDelegateUseCase: di.sl(),
        deleteDealerUseCase: di.sl(),
        deleteCustomerUseCase: di.sl(),
        deleteDelegateUseCase: di.sl(),
        getAllDealersUseCase: di.sl(),
        getAllCustomersUseCase: di.sl(),
        getAllDelegatesUseCase: di.sl(),
      )..getAllUsers(AccountType.delegate),
      child: Scaffold(
        appBar: mainAppBar(context),
        body: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            AccountCubit cubit=AccountCubit.get(context);
            if(state is DeleteAccountSuccessState){
              showToast(text: S.of(context).deleteSuccessfully, state: ToastState.SUCSSES);
              Navigator.of(context).pop();
              cubit.getAllUsers(AccountType.delegate);

            }
            if(state is DeleteAccountErrorState){
              showToast(text: S.of(context).deleteFailed, state: ToastState.ERROR);
              Navigator.of(context).pop();
            }
             if(state is DeleteAccountFailureState){
              showToast(text: '${S.of(context).deleteFailed} ${state.error}', state: ToastState.ERROR);
              Navigator.of(context).pop();
            }
            if (state is GetAllUsersLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }  if (state is GetAllUsersFailureState) {
              return Center(child: Text('Error: ${state.error}'));
            }
            if(state is GetAllUsersSuccessState&&state.users.isEmpty ){
              return const Center(child: Text('No data available',style: TextStyle(fontSize: 26),));
            }
            else {
              final List<Users> users = cubit.users;
              if (filteredUsers.isEmpty) {
                filteredUsers = users;
              }
              print(users.length);
              final screenWidth = MediaQuery.of(context).size.width;
              final screenHeight = MediaQuery.of(context).size.height;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.05),
                      FormWidget(
                        onChanged: (value) {
                          setState(() {
                            filteredUsers = users.where((user) {
                              return user.username!.toLowerCase().startsWith(value.toLowerCase());
                            }).toList();
                          });
                        },
                        label: S.of(context).delegateName,
                        controller: nameController,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Text(S.of(context).allDelegates, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: screenHeight * 0.01),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          final Users user = filteredUsers[index];
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  navigateTo(context,DetailDelegatePage(
                                      oldUsername: user.username!,
                                      oldPassword: user.password!));
                                },
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Text(user.username!),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 2.5),
                                      myDivider(context),
                                      const SizedBox(width: 2.5),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Text(user.password!,
                                                style: TextStyle(fontSize: screenWidth * 0.035,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit_outlined, color: Pallat.iconsAndButtonColor,size: screenWidth * 0.07,),
                                    onPressed: () {
                                      navigateTo(context, UpdateDelegatePage(id:user.id!,oldUsername: user.username!, oldPassword: user.password!,));
                                    },
                                  ),
                                  const SizedBox(width: 160,),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline_outlined, color: Colors.red,size: screenWidth * 0.07,),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                         return AlertMessage().alertDia(S.of(context).delegatee,context,
                                                  (){
                                           cubit.deleteAccount(user.id!,AccountType.delegate);
                                           return null;

                                                  });
                                        },
                                      );

                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
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
