import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final int? id;
  final String name;
  final String code;
  final double quantity;
  final double price;
  final String? unit;

  const Product({ this.id, required this.name, required this.code, required this.quantity, required this.price,  this.unit,});
  @override
  List<Object?> get props =>
      [id, name, code, quantity, price, unit];
}