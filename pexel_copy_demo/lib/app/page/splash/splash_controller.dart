import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:pexel_copy_demo/app/page/pages.dart';
import 'package:pexel_copy_demo/domain/entities/auth_user.dart';

import '../../utils/constant.dart';
import 'splash_presenter.dart';

class SplashController extends Controller {
  final SplashPresenter _splashPresenter;
  late bool isLoading;

  SplashController(authRepo)
      : _splashPresenter = SplashPresenter(authRepo),
        isLoading = false {
    getAuthUser();
  }

  /// Initializes [animation] for the view using a given [controller]
  void initAnimation(AnimationController controller, Animation animation) {
    animation.addStatusListener((status) {
      if (!isLoading) {
        controller.stop(canceled: true);
      } else if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  void initListeners() {
    _splashPresenter.getAuthStatusNext = authStatusOnNext;

    _splashPresenter.getAuthStatusError = (e) {
      dismissLoading();
      showGenericSnackbar(getStateKey(), e.toString(), isError: true);
    };

    _splashPresenter.getAuthStatusComplete = () => dismissLoading();
  }

  void authStatusOnNext(AuthUser? authUser) {
    String page = authUser == null || authUser == const AuthUser.empty() ? Pages.login : Pages.home;
    Navigator.of(getContext()).pushReplacementNamed(page);
  }

  void getAuthUser() async {
    isLoading = true;
    // so the animation can be seen
    Future.delayed(const Duration(seconds: 3), _splashPresenter.getAuthUser);
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }
}
