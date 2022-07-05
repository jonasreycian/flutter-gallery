import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
import 'package:pexel_copy_demo/app/page/pages.dart';

import 'app/page/login/login_view.dart';
import 'app/utils/app_router.dart';
import 'data/utils/api_exception.dart';

void main() {
  WidgetsFlutterBinding();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _router;

  MyApp({Key? key})
      : _router = AppRouter(),
        super(key: key) {
    initLogger();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterCleanArchitecture.debugModeOn();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }

  void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((rec) {
      dynamic e = rec.error;
      String? m = e is ApiException ? e.message : e.toString();
      debugPrint('${rec.loggerName}: ${rec.level.name}: ${rec.message} ${m ?? ''}');
    });
    Logger.root.info('Logger initialized');
  }
}
