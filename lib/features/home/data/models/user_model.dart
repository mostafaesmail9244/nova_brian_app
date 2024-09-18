import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserModel {
  final String name;
  final String email;
  final String id;

  const UserModel({
    required this.name,
    required this.email,
    required this.id,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      const UserModel(name: 'name', email: 'email', id: 'id');
}
