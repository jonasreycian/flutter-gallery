import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/entities/auth_user.dart';
import '../../../domain/usecases/auth/get_auth_usercase.dart';

class SplashPresenter extends Presenter {
  late Function getAuthStatusNext;
  late Function getAuthStatusError;
  late Function getAuthStatusComplete;

  late GetAuthUseCase _getAuthUseCase;

  SplashPresenter(authRepository) {
    _getAuthUseCase = GetAuthUseCase(authRepository);
  }

  void getAuthUser() => _getAuthUseCase.execute(_SplashObserver(this));

  @override
  void dispose() => _getAuthUseCase.dispose();
}

class _SplashObserver implements Observer<AuthUser> {
  final SplashPresenter _presenter;
  _SplashObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.getAuthStatusComplete();
  }

  @override
  void onError(e) {
    _presenter.getAuthStatusError(e);
  }

  @override
  void onNext(t) {
    if (t is AuthUser && t != const AuthUser.empty()) {
      _presenter.getAuthStatusError();
    }
    _presenter.getAuthStatusNext(t);
  }
}
