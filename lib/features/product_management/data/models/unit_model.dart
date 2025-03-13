import 'package:eks/features/product_management/domain/entities/unit_entity.dart';

class UnitModel extends Unit{
   const UnitModel(
      {
         super.id,
         super.type,});

  factory UnitModel.fromJson(Map<String, dynamic>? json) {
    return UnitModel(
        id : json!['id'],
        type : json['unit'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unit': type,
    };
  }

}
