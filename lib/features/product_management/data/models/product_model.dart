import 'package:eks/features/product_management/data/models/unit_model.dart';
import 'package:eks/features/product_management/domain/entities/product_entity.dart';

class ProductModel extends Product{
  const ProductModel(
      {
         super.id,
        required super.name,
        required super.code,
        required super.quantity,
        required super.price,
         super.unit,
         });

  factory ProductModel.fromJson(Map<String, dynamic>? json) {
    return ProductModel(
      id: json!['id'],
      name: json['name'],
      code: json['code'],
      unit: json['unit'],
      quantity: (json['quantity'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'quantity':quantity,
      'price':price,
      'unit': unit != null ? (unit as UnitModel).toJson() : null,
    };
  }

}
