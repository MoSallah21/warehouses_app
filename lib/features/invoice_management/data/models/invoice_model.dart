import 'package:eks/features/invoice_management/data/models/invoice_items_model.dart';
import 'package:eks/features/invoice_management/domain/entities/invoice_entity.dart';

class InvoiceModel extends Invoice {
  const InvoiceModel({
    super.id,
    required super.number,
    required super.date,
    required super.invoiceType,
    required super.clientName,
    super.userId,
    required super.totalPrice,
    required super.items
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      number: json['number'],  // Provide default value if null
      date: json['date'],
      invoiceType: json['invoice_type'],
      clientName: json['name'],
      items: (json['items'] as List?)?.map((item) => InvoiceItemsModel.fromJson(item)).toList() ?? [],
      totalPrice: json['total_price']?.toDouble(),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'date': date,
      'invoice_type': invoiceType,
      'name': clientName,
      'items': items?.map((item) => (item as InvoiceItemsModel).toJson()).toList(),
      'total_price': totalPrice,
      'user_id': userId,
    };
  }
}