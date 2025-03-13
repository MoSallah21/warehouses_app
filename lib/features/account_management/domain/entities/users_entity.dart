import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final int? id;
  final String? username;
  final String? accountType;
  final String? address;
  final String? phone;
  final String? password;
  final String? administratorName;
  final String? administratorPhone;
  final int? userId;

  const Users({ this.id, required this.username,  this.accountType,  this.address,  this.phone,  this.password,  this.administratorName,  this.administratorPhone,  this.userId});

  @override
  List<Object?> get props =>
      [id, username, accountType, address, phone, password, administratorName, administratorPhone,userId];
}
