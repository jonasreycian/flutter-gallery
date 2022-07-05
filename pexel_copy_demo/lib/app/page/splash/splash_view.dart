import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/repositories/data_auth_repository.dart';
import 'splash_controller.dart';

class SplashPage extends View {
  SplashPage({Key? key, required RouteObserver observer})
      : super(
          key: key,
          routeObserver: observer,
        );

  @override
  State<StatefulWidget> createState() => SplashPageViewState();
}

class SplashPageViewState extends ViewState<SplashPage, SplashController> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  SplashPageViewState() : super(SplashController(DataAuthRepository()));

  @override
  Widget get view {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    final controller = FlutterCleanArchitecture.getController<SplashController>(context);
    controller.initAnimation(_animationController, _animation);

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: _animation.value * 100,
          height: _animation.value * 100,
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
