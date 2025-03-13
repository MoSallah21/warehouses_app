import 'package:equatable/equatable.dart';

class InvoiceItems extends Equatable{
  final String productName;
  final double quantity;
  final double price;

  const InvoiceItems({required this.productName, required this.quantity, required this.price});


  @override
  List<Object?> get props =>
      [productName, quantity, price];
}