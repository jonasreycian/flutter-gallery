import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/auth_user.dart';
import '../../repositories/auth_repository.dart';

class GetAuthUseCase extends UseCase<AuthUser, GetAuthUseCaseParams> {
  final AuthRepository _authRepository;
  GetAuthUseCase(this._authRepository);

  @override
  Future<Stream<AuthUser?>> buildUseCaseStream(GetAuthUseCaseParams? params) async {
    final StreamController<AuthUser> controller = StreamController();
    try {
      AuthUser? user = await _authRepository.getAuthUser();
      controller.add(user!);
      logger.finest('GetAuthUseCase successful');
    } catch (e) {
      logger.severe("GetAuthUseCase unsuccessful. $e");
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetAuthUseCaseParams {
  final String email;
  final String password;

  GetAuthUseCaseParams(this.email, this.password);
}
