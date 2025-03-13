import 'package:eks/features/account_management/domain/entities/users_entity.dart';

class UsersModel extends Users {
  const UsersModel({
    super.id,
    required super.username,
    super.accountType,
    super.address,
    super.phone,
    super.password,
    super.administratorName,
    super.administratorPhone,
    super.userId,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'],
      username: json['username'],
      accountType: json['account_type'],
      address: json['address'],
      phone: json['phone'],
      password: json['password'],
      administratorName: json['administrator_name'],
      administratorPhone: json['administrator_phone'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'account_type': accountType,
      'address': address,
      'phone': phone,
      'password': password,
      'administrator_name': administratorName,
      'administrator_phone': administratorPhone,
      'user_id': userId,
    };
  }
}
