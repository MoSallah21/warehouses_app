import 'package:equatable/equatable.dart';

class Unit extends Equatable{
  final int? id;
  final String? type;

  const Unit({ this.id,  this.type});

  @override
  List<Object?> get props =>
      [id, type];
}