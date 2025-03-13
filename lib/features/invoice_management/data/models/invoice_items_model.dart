import 'package:eks/features/invoice_management/domain/entities/invoice_items_entity.dart';

class InvoiceItemsModel extends InvoiceItems {
  const InvoiceItemsModel({
    required super.productName,
    required super.quantity,
    required super.price,
  });

  factory InvoiceItemsModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemsModel(
      productName: json['name'] ?? '',
      quantity: (json['quantity'] ?? 0).toDouble(),
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}