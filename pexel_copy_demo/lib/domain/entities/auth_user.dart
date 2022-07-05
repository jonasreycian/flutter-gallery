import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String email;
  final String password;
  final String? name;

  @override
  List<Object?> get props => [id, email, password, name];

  const AuthUser(this.id, this.email, this.password, {this.name});

  const AuthUser.empty()
      : id = '',
        email = '',
        password = '',
        name = null;

  AuthUser.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        email = json['email'] as String,
        password = json['password'] as String,
        name = json['name'] as String;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
    };
  }
}
