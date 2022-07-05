import 'package:pexel_copy_demo/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser?> getAuthUser();
  Future<void> login(String email, String password);
  Future<void> register(String email, String password, String? name);
  Future<void> logout();
}
