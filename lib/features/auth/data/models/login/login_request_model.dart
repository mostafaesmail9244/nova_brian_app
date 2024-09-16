import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestBody {
  final String email;
  final String password;
  const LoginRequestBody({required this.email, required this.password});
  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);
}
