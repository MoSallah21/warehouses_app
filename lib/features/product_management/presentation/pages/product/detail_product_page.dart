import 'package:eks/core/widgets/logo_widget.dart';
import 'package:eks/generated/l10n.dart';
import 'package:flutter/material.dart';


class DetailProductPage extends StatelessWidget {
  final String oldName;
  final String oldCode;
  final String? oldUnit;
  final double oldPrice;
  final double oldQuantity;


  DetailProductPage({super.key, required this.oldName, required this.oldCode,required this.oldUnit, required this.oldPrice, required this.oldQuantity});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05),
              LogoWidget(height: screenHeight * 0.2),
              SizedBox(height: screenHeight * 0.04),
              Column(
                children: [
                  Row(
                    children: [
                      Text('${S.of(context).name} :   ',style: const TextStyle(fontSize: 24),),
                      Text(oldName,style: const TextStyle(fontSize: 24)),

                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                children: [
                  Text('${S.of(context).code} :   ',style: const TextStyle(fontSize: 24),),
                  Text(oldCode,style: const TextStyle(fontSize: 24)),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                children: [
                  Text('${S.of(context).quantity} :   ',style: const TextStyle(fontSize: 24),),
                  Text(oldQuantity.toString(),style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 10),
                  Text(
                      '   ${oldUnit!}'
                      ,style: const TextStyle(fontSize: 24) ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                children: [
                  Text('${S.of(context).price} :   ',style: const TextStyle(fontSize: 24)),
                  Text(oldPrice.toString(),style: const TextStyle(fontSize: 24)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}