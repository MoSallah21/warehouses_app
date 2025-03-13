import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

class DetailCustomerPage extends StatelessWidget {
  final String oldUsername;
  final String oldAddress;
  final String oldPhone;
  final String oldAdministratorName;
  final String oldAdministratorPhone;
  DetailCustomerPage({super.key, required this.oldUsername, required this.oldAddress, required this.oldPhone, required this.oldAdministratorName, required this.oldAdministratorPhone});


  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: mainAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                LogoWidget(height: screenHeight * 0.2),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  children: [
                    const Text(
                        'الاسم:   ',style: TextStyle(fontSize: 24)
                    ),

                    Text(
                        oldUsername,style: const TextStyle(fontSize: 24)
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    const Text(
                      'العنوان: ',style: TextStyle(fontSize: 24),
                    ),

                    Text(
                        oldAddress,style: const TextStyle(fontSize: 24)
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    const Text(
                      'رقم الموبايل:  ',style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      oldPhone,style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    const Text(
                      'اسم المسؤول:   ',style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      oldAdministratorName,style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    const Text(
                      'رقم موبايل المسؤول:  ',style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      oldAdministratorPhone,style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
