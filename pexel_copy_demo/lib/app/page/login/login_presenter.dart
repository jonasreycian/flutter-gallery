import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/auth/login_usecase.dart';

class LoginPresenter extends Presenter {
  final AuthRepository _authRepository;
  late LoginUseCase _loginUseCase;

  // Controller Callback
  late Function loginOnComplete;
  late Function loginOnError;

  LoginPresenter(this._authRepository) {
    // Initialized [UseCase] with the appropriate repository
    _loginUseCase = LoginUseCase(_authRepository);
  }

  // Dispose of the [LoginUseCase] and unsubscribe from the [Stream]
  @override
  void dispose() {
    _loginUseCase.dispose();
  }

  void login(String email, String password) {
    _loginUseCase.execute(
      _LoginUseCaseObserver(this),
      LoginUseCaseParams(email, password),
    );
  }
}

class _LoginUseCaseObserver implements Observer<void> {
  // The above presenter
  final LoginPresenter _loginPresenter;
  _LoginUseCaseObserver(this._loginPresenter);

  @override
  void onComplete() {
    _loginPresenter.loginOnComplete();
  }

  // Login was unsuccessful, trigger event in [LoginController]
  @override
  void onError(e) => _loginPresenter.loginOnError(e);

  // Implements if the `Observable` emits a new value
  @override
  void onNext(void response) {}
}
