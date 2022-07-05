import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CounterPresenter extends Presenter {
  late Function onNext;
  late Function onError;
  late Function onComplete;

  CounterPresenter() : super();

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
