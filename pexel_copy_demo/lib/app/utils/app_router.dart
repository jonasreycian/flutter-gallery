import 'package:flutter/material.dart';
import '../page/pages.dart';

class AppRouter {
  final RouteObserver<PageRoute> routeObserver;

  AppRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.home:
        return _buildRoute(settings, HomePage());
      case Pages.splash:
        return _buildRoute(settings, SplashPage(observer: routeObserver));
      case Pages.login:
        return _buildRoute(settings, LoginPage());
      default:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => builder,
    );
  }
}
