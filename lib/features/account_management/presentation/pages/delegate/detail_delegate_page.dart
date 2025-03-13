import 'package:eks/core/components/components.dart';
import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';

class DetailDelegatePage extends StatelessWidget {
  final String oldUsername;
  final String oldPassword;
  DetailDelegatePage({super.key,required this.oldUsername, required this.oldPassword});


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
                    Text(
                        '${S.of(context).name}:   ',style: const TextStyle(fontSize: 24)
                    ),

                    Text(
                        oldUsername,style: const TextStyle(fontSize: 24)
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    Text(
                      '${S.of(context).password}: ',style: const TextStyle(fontSize: 24),
                    ),

                    Text(
                        oldPassword,style: const TextStyle(fontSize: 24)
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
