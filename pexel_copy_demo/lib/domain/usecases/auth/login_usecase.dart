import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

import '../../entities/auth_user.dart';
import '../../repositories/auth_repository.dart';

class LoginUseCase extends CompletableUseCase<LoginUseCaseParams> {
  // Members
  final AuthRepository _authRepository;
  late Logger _logger;

  // Constructor
  LoginUseCase(this._authRepository) : super() {
    _logger = Logger('LoginUseCase');
  }

  @override
  Future<Stream<AuthUser>> buildUseCaseStream(LoginUseCaseParams? params) async {
    final StreamController<AuthUser> streamController = StreamController<AuthUser>.broadcast();
    try {
      await _authRepository.login(params!._email, params._password);
      streamController.close();
    } catch (e) {
      _logger.severe('LoginUseCase::buildUseCaseStream: Could not login the user. ${e.toString()}');
      streamController.addError(e);
    }
    return streamController.stream;
  }
}

// The parameters required for the [LoginUseCase]
class LoginUseCaseParams {
  final String _email;
  final String _password;

  LoginUseCaseParams(this._email, this._password);
}
