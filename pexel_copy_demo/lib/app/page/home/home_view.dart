import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:pexel_copy_demo/data/repositories/data_photo_repository.dart';

import 'home_controller.dart';

class HomePage extends View {
  HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends ResponsiveViewState<HomePage, HomeController> {
  HomePageState() : super(HomeController(DataPhotoRepository()));

  Widget get buildView => const Scaffold(
        body: Center(
          child: Text('Home'),
        ),
      );

  @override
  Widget get desktopView => buildView;

  @override
  Widget get mobileView => buildView;

  @override
  Widget get tabletView => buildView;

  @override
  Widget get watchView => buildView;
}
