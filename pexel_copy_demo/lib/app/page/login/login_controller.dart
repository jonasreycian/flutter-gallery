import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:pexel_copy_demo/app/page/login/login_presenter.dart';

import '../../utils/constant.dart';
import '../pages.dart';

class LoginController extends Controller {
  // Text field controllers
  late TextEditingController emailTextController;
  late TextEditingController passwordController;
  late bool isLoading;
  final LoginPresenter _loginPresenter;

  // Constructor
  LoginController(authRepo) : _loginPresenter = LoginPresenter(authRepo) {
    emailTextController = TextEditingController();
    passwordController = TextEditingController();
    isLoading = false;
    initListeners();
  }

  // Initialized [Presenter] listeners

  @override
  void initListeners() {
    _loginPresenter.loginOnComplete = _loginOnComplete;
    _loginPresenter.loginOnError = _loginOnError;
  }

  /// Login is successful
  void _loginOnComplete() {
    dismissLoading();
    Navigator.of(getContext()).pushReplacementNamed(Pages.home);
  }

  /// Login was unsuccessful
  void _loginOnError(e) {
    dismissLoading();
    showGenericSnackbar(getStateKey(), e.toString(), isError: true);
  }

  void login() async {
    isLoading = true;
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  // Navigates to [RegisterPage]
  void register() {
    Navigator.of(getContext()).pushNamed(Pages.register);
  }

  // Navigates to [ForgotPasswordPage]
  void forgotPassword() {
    Navigator.of(getContext()).pushNamed(Pages.forgotPassword);
  }
}
