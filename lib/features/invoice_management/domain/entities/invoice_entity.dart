import 'package:eks/features/invoice_management/domain/entities/invoice_items_entity.dart';
import 'package:equatable/equatable.dart';

class Invoice extends Equatable{
  final int? id;
  final String number;
  final String date;
  final String invoiceType;
  final String clientName;
  final List<InvoiceItems>? items;
  final int? userId;
  final double?totalPrice;
  const Invoice({ this.id, required this.number, required this.date, required this.invoiceType, required this.clientName, required this.items,required this.totalPrice,this.userId});

  @override
  List<Object?> get props =>
      [id, number, date, invoiceType, clientName,items, userId,totalPrice];
}